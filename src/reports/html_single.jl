# Single-sample HTML report: summary tiles, the distribution charts of the
# multi-sample page (one series) and, when available, the FastQC-compatible
# modules (flags, per-base quality bands, base content, N, adapters,
# overrepresented sequences). Self-contained, same styles and script as the
# multi-sample page.

_group_mid(label::AbstractString) = (p = split(label, '-'); length(p) == 1 ? parse(Float64, p[1]) :
                                                                  (parse(Float64, p[1]) + parse(Float64, p[2])) / 2)
_group_tip(label::AbstractString) = occursin('-', label) ? "positions " * replace(label, "-" => "–") : "position " * label

function _tile(io, label, value; note = "")
    print(io, """<div class="tile"><div class="tv">$(_esc(value))</div><div class="tl">$(_esc(label))</div>""")
    isempty(note) || print(io, """<div class="tn">$(_esc(note))</div>""")
    println(io, "</div>")
end

# Per-base quality: 10-90% and 25-75% bands, median and mean lines.
function _band_svg(io, id, x, tips, q)
    c = _Chart(id, "", "", x, false, "Position in read (bp)", _lenlabel, tips,
               permutedims(hcat(q.mean, q.median, q.lower_quartile, q.upper_quartile, q.percentile_10, q.percentile_90)),
               :phred)
    sx = _xscale(c)
    vals = filter(isfinite, c.y)
    yticks, ytop = _nice_ticks(isempty(vals) ? 40.0 : maximum(vals))
    sy(v) = (_H - _MB) - v / ytop * (_H - _MB - _MT)
    println(io, """<svg class="chart line" viewBox="0 0 $(_W) $(_H)" role="img" aria-label="Quality per base" data-chart="$(id)">""")
    _axes_svg(io, c, ytop, yticks, _H, sx)
    for (lo, hi, cls) in ((5, 6, "band1"), (3, 4, "band2"))
        pts = [(sx(x[j]), sy(c.y[hi, j])) for j in eachindex(x) if isfinite(c.y[hi, j]) && isfinite(c.y[lo, j])]
        back = [(sx(x[j]), sy(c.y[lo, j])) for j in reverse(eachindex(x)) if isfinite(c.y[hi, j]) && isfinite(c.y[lo, j])]
        isempty(pts) && continue
        println(io, """<polygon class="$(cls)" points="$(join(("$(round(a; digits = 1)),$(round(b; digits = 1))" for (a, b) in vcat(pts, back)), " "))"/>""")
    end
    for (row, cls) in ((2, "s0"), (1, "s1"))
        d = IOBuffer()
        pen = false
        for j in eachindex(x)
            v = c.y[row, j]
            if isfinite(v)
                print(d, pen ? "L" : "M", round(sx(x[j]); digits = 1), ",", round(sy(v); digits = 1))
                pen = true
            else
                pen = false
            end
        end
        println(io, """<path class="series $(cls)" data-series="$(row - 1)" d="$(String(take!(d)))"/>""")
    end
    println(io, """<line class="crosshair" x1="0" x2="0" y1="$(_MT)" y2="$(_H - _MB)" visibility="hidden"/>""",
            """<rect class="hit" x="$(_ML)" y="$(_MT)" width="$(_W - _ML - _MR)" height="$(_H - _MB - _MT)"/>""")
    println(io, "</svg>")
    return (id = id, kind = "line", unit = :phred, px = [round(sx(v); digits = 1) for v in x], tips = tips,
            series = ["Mean", "Median", "Lower quartile", "Upper quartile", "10th percentile", "90th percentile"],
            keys = [1, 0, nothing, nothing, nothing, nothing], y = [c.y[i, :] for i in 1:6])
end

function _series_chart(io, id, title, subtitle, x, tips, names, y; unit = :percent, keys = nothing)
    c = _Chart(id, title, subtitle, x, false, "Position in read (bp)", _lenlabel, tips, y, unit)
    println(io, """<section class="card"><h2>$(_esc(title))</h2><p class="sub">$(_esc(subtitle))</p>""")
    px = _line_svg(io, c, 1:size(y, 1); attr = "data-series")
    if length(names) > 1
        println(io, """<div class="legend static">""")
        for (i, n) in enumerate(names)
            println(io, """<span class="lgs"><i class="key k$(something(keys, 0:length(names)-1)[i])"></i>$(_esc(n))</span>""")
        end
        println(io, "</div>")
    end
    println(io, "</section>")
    return (id = id, kind = "line", unit = unit, px = px, tips = tips, series = names,
            keys = keys === nothing ? collect(0:length(names)-1) : keys, y = [y[i, :] for i in axes(y, 1)])
end

const _STATUS_ICON = Dict("pass" => "✓", "warn" => "!", "fail" => "✕")

"""
    write_html(io, result::QCResult; title = nothing)

Single-sample HTML report (usually via `report(result, "sample.html")`).
"""
function write_html(io::IO, r::QCResult; title = nothing)
    s = aggregate([r]; low_reads_fraction = 0.0)
    name = s.samples[1]
    title = something(title, "SeqQC report — " * name)
    charts = _charts(s)
    chartdata = Any[]
    body = IOBuffer()
    for c in charts
        all(!isfinite, c.y) && continue
        println(body, """<section class="card"><h2>$(_esc(c.title))</h2><p class="sub">$(_esc(c.subtitle))</p>""")
        px = _line_svg(body, c, 1:1)
        push!(chartdata, (id = c.id, kind = "line", unit = c.unit, px = px, tips = c.xtips, series = [name],
                          keys = [0], y = [c.y[1, :]]))
        println(body, "</section>")
    end

    # FastQC-compatible modules
    fq = IOBuffer()
    hasfastqc = haskey(r.metrics, :per_position) && haskey(r.metrics, :quality) && haskey(r.metrics, :read_length)
    if hasfastqc
        m = try
            FastQC.modules(r)
        catch err
            err isa ArgumentError || rethrow()
            println(fq, """<section class="card wide"><h2>FastQC-compatible modules</h2><p class="sub">Not available: $(_esc(err.msg))</p></section>""")
            nothing
        end
        if m !== nothing
            println(fq, """<section class="card wide"><h2>FastQC-compatible modules</h2>
<p class="sub">Tables and pass/warn/fail flags computed with FastQC 0.12.1's rules (docs/FASTQC.md). Not computed:
sequence duplication levels, per-tile quality, k-mer content, and the per-sequence GC flag.</p><div class="flags">""")
            for (k, label) in pairs(_FASTQC_MODULE_NAMES)
                f = get(m.flags, k, nothing)
                (k === :per_sequence_gc || f === nothing) && continue
                st = string(f)
                println(fq, """<span class="flag $(st)">$(_STATUS_ICON[st]) $(_esc(label)): $(st)</span>""")
            end
            println(fq, "</div></section>")
            q = m.per_base_quality
            if isempty(q.base)                   # no read positions (e.g. an empty input)
                println(fq, """<section class="card wide"><h2>Per-position modules</h2><p class="sub">No read positions: """,
                        """the input has no bases, so there is nothing to plot by position.</p></section>""")
            else
            x = _group_mid.(q.base)
            tips = _group_tip.(q.base)
            println(fq, """<section class="card"><h2>Quality per base</h2><p class="sub">Median (blue) and mean (orange) Phred score;
bands: 25–75% and 10–90% of the scores at each position (FastQC grouping; quantiles need more than 100 bases)</p>""")
            push!(chartdata, _band_svg(fq, "fq_q", x, tips, q))
            println(fq, """<div class="legend static"><span class="lgs"><i class="key k0"></i>Median</span><span class="lgs"><i class="key k1"></i>Mean</span>
<span class="lgs"><i class="swatch band2"></i>25–75%</span><span class="lgs"><i class="swatch band1"></i>10–90%</span></div></section>""")
            c = m.per_base_content
            push!(chartdata, _series_chart(fq, "fq_c", "Base content per position",
                "Percentage of A, C, G, T among the A/C/G/T bases at each position", _group_mid.(c.base), _group_tip.(c.base),
                ["A", "C", "G", "T"], permutedims(hcat(c.A, c.C, c.G, c.T))))
            n = m.per_base_n_content
            push!(chartdata, _series_chart(fq, "fq_n", "N per position", "Percentage of N among all bases at each position",
                _group_mid.(n.base), _group_tip.(n.base), ["N"], reshape(n.n_count, 1, :)))
            if m.adapter_content !== nothing && !isempty(m.adapter_content.position)
                a = m.adapter_content
                push!(chartdata, _series_chart(fq, "fq_a", "Adapter content",
                    "Cumulative percentage of reads with each adapter starting at or before the position",
                    _group_mid.(a.position), _group_tip.(a.position), a.names, permutedims(reduce(hcat, a.values))))
            end
            end   # positions present
            if m.overrepresented_sequences !== nothing
                o = m.overrepresented_sequences
                println(fq, """<section class="card wide"><h2>Overrepresented sequences</h2><p class="sub">First 50 bases of reads
making up more than 0.1% of the total (FastQC rules)$(o.possible_source === nothing ? "; possible sources not computed (no contaminant list)" : "")</p>""")
                if isempty(o.sequence)
                    println(fq, "<p>None.</p>")
                else
                    println(fq, """<div class="tablewrap"><table><thead><tr><th>Sequence</th><th class="num">Count</th><th class="num">%</th><th>Possible source</th></tr></thead><tbody>""")
                    for i in eachindex(o.sequence)
                        println(fq, "<tr><td><code>", _esc(o.sequence[i]), "</code></td><td class=\"num\">", _commas(o.count[i]),
                                "</td><td class=\"num\">", round(o.percentage[i]; digits = 3), "</td><td>",
                                o.possible_source === nothing ? "–" : _esc(o.possible_source[i]), "</td></tr>")
                    end
                    println(fq, "</tbody></table></div>")
                end
                println(fq, "</section>")
            end
        end
    end

    data = (samples = s.samples, charts = chartdata)
    js = IOBuffer()
    _json(js, data, ())
    jsondata = replace(String(take!(js)), "<" => "\\u003c")
    t = s.table
    println(io, """<!DOCTYPE html><html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$(_esc(title))</title><style>$(_CSS)$(_SINGLE_CSS)
$(join((".viz-root .s$(i-1){stroke:$(_CAT_LIGHT[i])} .viz-root .k$(i-1){background:$(_CAT_LIGHT[i])}" for i in 1:8), "\n"))
@media (prefers-color-scheme: dark){ :root:where(:not([data-theme="light"])) .viz-root{
$(join((".s$(i-1){stroke:$(_CAT_DARK[i])} .k$(i-1){background:$(_CAT_DARK[i])}" for i in 1:8), "\n"))}}
</style></head><body><div class="viz-root">
<header><h1>$(_esc(title))</h1>
<p class="meta">$(_esc(r.input.path)) · $(_esc(string(r.input.compression))) · Phred+$(r.settings.phred_offset) ·
SeqQC $(_esc(VERSION_STRING)) · $(_esc(Libc.strftime("%Y-%m-%d %H:%M", time())))$(r.settings.sampling === :head ? " · <b>head sampling: first $(r.total_reads) reads only</b>" : "")</p></header>""")
    if !isempty(r.warnings)
        println(io, """<details class="warnings" open><summary>⚠ $(length(r.warnings)) warning$(length(r.warnings) == 1 ? "" : "s")</summary><ul>""")
        foreach(w -> println(io, "<li>", _esc(w), "</li>"), r.warnings)
        println(io, "</ul></details>")
    end
    println(io, """<div class="tiles">""")
    _tile(io, "Reads", _cell(t.reads[1]))
    _tile(io, "Bases", _cell(t.bases[1]))
    _tile(io, "Read N50", _cell(t.n50[1]); note = "bp")
    _tile(io, "Median length", _cell(t.median_length[1]); note = "bp")
    _tile(io, "Mean read quality", t.mean_read_quality[1] === nothing ? "–" : "Q" * _cell(t.mean_read_quality[1]);
          note = "error-probability mean")
    _tile(io, "Reads ≥ Q20", t.percent_reads_q20[1] === nothing ? "–" : _cell(t.percent_reads_q20[1]) * "%")
    _tile(io, "GC", t.gc_percent[1] === nothing ? "–" : _cell(t.gc_percent[1]) * "%")
    println(io, "</div>")
    println(io, """<div class="grid2">""", String(take!(body)), String(take!(fq)), "</div>")
    println(io, """<footer><p>Definitions: SeqQC <code>docs/METRICS.md</code>; FastQC-compatible modules:
<code>docs/FASTQC.md</code>. All values are also in the JSON report (<code>report(result, "x.json")</code>).</p></footer></div>
<div id="tip" role="tooltip" hidden></div>
<script type="application/json" id="seqqc-data">$(jsondata)</script>
<script>$(_JS)</script></body></html>""")
    return nothing
end

const _SINGLE_CSS = raw"""
.tiles{display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:12px;margin:16px 0}
.tile{background:var(--surface-1);border:1px solid var(--border);border-radius:10px;padding:12px 14px}
.tv{font-size:24px;font-weight:600}.tl{color:var(--ink2);font-size:13px;margin-top:2px}.tn{color:var(--muted);font-size:11px}
.card.wide{grid-column:1/-1}
.flags{display:flex;flex-wrap:wrap;gap:6px;margin-top:8px}
.flags .flag{font-size:13px;padding:3px 8px}
.legend.static{margin:6px 0 0}.lgs{display:inline-flex;align-items:center;margin-right:12px;font-size:12px;color:var(--ink2)}
.swatch{display:inline-block;width:14px;height:10px;margin-right:6px;border-radius:2px}
.band1{fill:#cde2fb}.band2{fill:#9ec5f4}.swatch.band1{background:#cde2fb}.swatch.band2{background:#9ec5f4}
@media (prefers-color-scheme: dark){:root:where(:not([data-theme="light"])) .viz-root{}
 :root:where(:not([data-theme="light"])) .band1{fill:#184f95}:root:where(:not([data-theme="light"])) .band2{fill:#256abf}
 :root:where(:not([data-theme="light"])) .swatch.band1{background:#184f95}:root:where(:not([data-theme="light"])) .swatch.band2{background:#256abf}}
code{font-size:12px}
"""
