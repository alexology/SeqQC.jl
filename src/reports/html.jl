# Self-contained HTML report for a SampleSet: summary table + distribution
# charts (inline SVG, no external resources). Line charts for <= 8 samples
# (validated categorical palette), heatmaps beyond (sequential blue ramp).
# Minimal interactivity: sortable/filterable table, sample highlight, tooltips.

const _CAT_LIGHT = ("#2a78d6", "#eb6834", "#1baf7a", "#eda100", "#e87ba4", "#008300", "#6250d6", "#e34948")
const _CAT_DARK = ("#3987e5", "#d95926", "#199e70", "#c98500", "#d55181", "#008300", "#9085e9", "#e66767")
const _SEQ_BLUE = ("#cde2fb", "#b7d3f6", "#9ec5f4", "#86b6ef", "#6da7ec", "#5598e7", "#3987e5", "#2a78d6",
                   "#256abf", "#1c5cab", "#184f95", "#104281", "#0d366b")
const _MAX_LINE_SAMPLES = 8

_esc(s) = replace(string(s), "&" => "&amp;", "<" => "&lt;", ">" => "&gt;", "\"" => "&quot;", "'" => "&#39;")

function _commas(n::Integer)
    s = string(abs(n))
    out = reverse(join(Iterators.partition(reverse(s), 3) .|> String, ","))
    return n < 0 ? "-" * out : out
end
_cell(x::Nothing; digits = 1) = "–"
_cell(x::Integer; digits = 1) = _commas(x)
_cell(x::AbstractFloat; digits = 1) = !isfinite(x) ? "–" : (isinteger(x) || abs(x) >= 1e5) ? _commas(round(Int, x)) : string(round(x; digits))

# "Nice" axis ticks for [0, ymax].
function _nice_ticks(ymax::Float64; n = 4)
    ymax <= 0 && return [0.0], 1.0
    raw = ymax / n
    p = 10.0^floor(log10(raw))
    step = first(s * p for s in (1, 2, 2.5, 5, 10) if s * p >= raw)
    top = ceil(ymax / step) * step
    return collect(0:step:top), top
end

_pctlabel(x) = (v = round(100x; digits = 2); v == round(v) ? string(Int(v), "%") : string(v, "%"))

function _lenlabel(x::Real)
    x >= 1_000_000 && return string(round(x / 1e6; digits = 1), " Mb")
    x >= 1000 && return string(x / 1000 == round(x / 1000) ? Int(x ÷ 1000) : round(x / 1000; digits = 1), " kb")
    return string(Int(round(x)))
end

# One chart: x positions (data units, plotted on linear or log10 scale), y matrix
# (samples × points, fractions), labels for tooltips.
struct _Chart
    id::String
    title::String
    subtitle::String
    x::Vector{Float64}
    xlog::Bool
    xlabel::String
    xticklabel::Function
    xtips::Vector{String}
    y::Matrix{Float64}
    unit::Symbol            # :fraction (shown as %) or :phred
end

_Chart(id, title, subtitle, x, xlog, xlabel, xtl, xtips, y) =
    _Chart(id, title, subtitle, x, xlog, xlabel, xtl, xtips, y, :fraction)

_ylabel(c::_Chart, v) = c.unit === :fraction ? _pctlabel(v) :
    c.unit === :percent ? string(isinteger(v) ? Int(v) : round(v; digits = 1), "%") :
    (isinteger(v) ? string(Int(v)) : string(round(v; digits = 1)))

const _W, _H, _ML, _MR, _MT, _MB = 680, 240, 56, 16, 12, 40

function _xscale(c::_Chart)
    t(x) = c.xlog ? log10(max(x, 1e-9)) : x
    lo, hi = t(first(c.x)), t(last(c.x))
    hi == lo && (hi = lo + 1)
    return x -> _ML + (t(x) - lo) / (hi - lo) * (_W - _ML - _MR)
end

function _xticks(c::_Chart)
    if c.xlog
        lo, hi = first(c.x), last(c.x)
        ticks = [10.0^k for k in floor(Int, log10(max(lo, 1))):ceil(Int, log10(hi)) if lo <= 10.0^k <= hi]
        length(ticks) < 2 && (ticks = [lo, hi])
        return ticks
    end
    lo, hi = first(c.x), last(c.x)
    span = hi - lo
    span <= 0 && return [lo]
    p = 10.0^floor(log10(span / 5))
    step = first(s * p for s in (1, 2, 2.5, 5, 10) if s * p >= span / 6)
    return collect((ceil(lo / step) * step):step:hi)
end

function _axes_svg(io, c::_Chart, ytop, yticks, height, sx; ybottom = 0.0)
    plotb = height - _MB
    for t in yticks
        y = plotb - (t - ybottom) / (ytop - ybottom) * (plotb - _MT)
        println(io, """<line class="grid" x1="$(_ML)" x2="$(_W - _MR)" y1="$(round(y; digits = 1))" y2="$(round(y; digits = 1))"/>""",
                """<text class="tick" x="$(_ML - 6)" y="$(round(y + 4; digits = 1))" text-anchor="end">$(_ylabel(c, t))</text>""")
    end
    println(io, """<line class="axis" x1="$(_ML)" x2="$(_W - _MR)" y1="$(plotb)" y2="$(plotb)"/>""")
    for t in _xticks(c)
        x = round(sx(t); digits = 1)
        println(io, """<line class="axis" x1="$x" x2="$x" y1="$(plotb)" y2="$(plotb + 4)"/>""",
                """<text class="tick" x="$x" y="$(plotb + 16)" text-anchor="middle">$(_esc(c.xticklabel(t)))</text>""")
    end
    println(io, """<text class="axis-title" x="$((_ML + _W - _MR) ÷ 2)" y="$(height - 4)" text-anchor="middle">$(_esc(c.xlabel))</text>""")
end

function _line_svg(io, c::_Chart, visible_rows; attr = "data-sample")
    sx = _xscale(c)
    vals = filter(isfinite, c.y)
    yticks, ytop = _nice_ticks(isempty(vals) ? 0.0 : maximum(vals))
    ybottom = 0.0
    if c.unit === :phred && !isempty(vals)
        # quality: start the axis near the data (a zero baseline would flatten the lines)
        step = length(yticks) > 1 ? yticks[2] - yticks[1] : 1.0
        ybottom = max(0.0, floor(minimum(vals) / step) * step)
        if ytop <= ybottom                       # constant values: keep a one-step axis
            ytop = ybottom + step
            yticks = [ybottom, ytop]
        end
        yticks = [t for t in yticks if t >= ybottom]
    end
    sy(v) = (_H - _MB) - (v - ybottom) / (ytop - ybottom) * (_H - _MB - _MT)
    println(io, """<svg class="chart line" viewBox="0 0 $(_W) $(_H)" role="img" aria-label="$(_esc(c.title))" data-chart="$(c.id)">""")
    _axes_svg(io, c, ytop, yticks, _H, sx; ybottom)
    for i in visible_rows
        d = IOBuffer()
        pen = false
        for (j, x) in enumerate(c.x)
            v = c.y[i, j]
            if isfinite(v)
                print(d, pen ? "L" : "M", round(sx(x); digits = 1), ",", round(sy(v); digits = 1))
                pen = true
            else
                pen = false
            end
        end
        path = String(take!(d))
        isempty(path) && continue
        println(io, """<path class="series s$(i - 1)" $(attr)="$(i - 1)" d="$path"/>""")
    end
    println(io, """<line class="crosshair" x1="0" x2="0" y1="$(_MT)" y2="$(_H - _MB)" visibility="hidden"/>""",
            """<rect class="hit" x="$(_ML)" y="$(_MT)" width="$(_W - _ML - _MR)" height="$(_H - _MB - _MT)"/>""")
    println(io, "</svg>")
    return [round(sx(x); digits = 1) for x in c.x]
end

function _heat_svg(io, c::_Chart, names)
    n = size(c.y, 1)
    rowh = clamp(round(Int, 320 / n), 6, 16)
    height = _MT + n * rowh + _MB
    sx = _xscale(c)
    # cell edges: midpoints between x positions, on the plotted scale
    px = [sx(x) for x in c.x]
    edges = [px[1] - (length(px) > 1 ? (px[2] - px[1]) / 2 : 5); [(px[k] + px[k+1]) / 2 for k in 1:length(px)-1];
             px[end] + (length(px) > 1 ? (px[end] - px[end-1]) / 2 : 5)]
    edges = clamp.(edges, _ML, _W - _MR)
    vals = filter(isfinite, c.y)
    vmax = isempty(vals) ? 1.0 : max(maximum(vals), eps())
    # fractions: scale from 0; quality: from the minimum observed value
    vmin = c.unit === :phred && !isempty(vals) ? minimum(vals) : 0.0
    vmax <= vmin && (vmax = vmin + 1)
    println(io, """<svg class="chart heat" viewBox="0 0 $(_W) $(height)" role="img" aria-label="$(_esc(c.title))" data-chart="$(c.id)" data-vmax="$(vmax)">""")
    every = max(1, ceil(Int, 10 / rowh))          # label every k-th row, >= 10 px apart
    for i in 1:n
        y = _MT + (i - 1) * rowh
        print(io, """<g class="row" data-sample="$(i - 1)">""")
        if (i - 1) % every == 0
            print(io, """<text class="rowlabel" x="$(_ML - 4)" y="$(y + min(rowh, 10) - 1)" text-anchor="end">$(_esc(length(names[i]) > 14 ? first(names[i], 13) * "…" : names[i]))<title>$(_esc(names[i]))</title></text>""")
        end
        # row background: zero (surface) or no data (muted); only positive cells are drawn
        allna = all(!isfinite, view(c.y, i, :))
        print(io, """<rect class="rowbg" x="$(_ML)" y="$y" width="$(_W - _ML - _MR)" height="$(rowh - 1)" fill="$(allna ? "var(--na)" : "var(--surface-1)")"/>""")
        for j in eachindex(c.x)
            v = c.y[i, j]
            (isfinite(v) && (c.unit === :phred || v > 0)) || continue
            fill = _SEQ_BLUE[clamp(ceil(Int, (v - vmin) / (vmax - vmin) * length(_SEQ_BLUE)), 1, length(_SEQ_BLUE))]
            w = max(edges[j+1] - edges[j], 0.5)
            print(io, """<rect class="cell" x="$(round(edges[j]; digits = 1))" y="$y" width="$(round(w; digits = 2))" height="$(rowh - 1)" fill="$fill" data-c="$(j - 1)"/>""")
        end
        println(io, "</g>")
    end
    plotb = height - _MB
    for t in _xticks(c)
        x = round(sx(t); digits = 1)
        println(io, """<line class="axis" x1="$x" x2="$x" y1="$(plotb)" y2="$(plotb + 4)"/>""",
                """<text class="tick" x="$x" y="$(plotb + 16)" text-anchor="middle">$(_esc(c.xticklabel(t)))</text>""")
    end
    println(io, """<text class="axis-title" x="$((_ML + _W - _MR) ÷ 2)" y="$(height - 4)" text-anchor="middle">$(_esc(c.xlabel))</text>""")
    println(io, "</svg>")
    # gradient legend
    lo, hi = c.unit === :phred ? (string("Q", round(vmin; digits = 1)), string("Q", round(vmax; digits = 1))) :
             ("0%", _pctlabel(vmax))
    println(io, """<div class="ramp"><span>$(lo)</span><span class="bar">""",
            join(("""<i style="background:$c"></i>""" for c in _SEQ_BLUE)), """</span><span>$(hi)</span></div>""")
    return nothing
end

function _charts(s::SampleSet)
    L = s.series.length
    edges = L.edges
    xlen = L.scale === :log ? [sqrt(max(edges[k], 1) * max(edges[k+1] - 1, 1)) for k in 1:length(edges)-1] :
           [(edges[k] + edges[k+1] - 1) / 2 for k in 1:length(edges)-1]
    lentips = [edges[k+1] - edges[k] == 1 ? "$(edges[k]) bp" : "$(edges[k])–$(edges[k+1] - 1) bp" for k in 1:length(edges)-1]
    ytips = ["≥ $(edges[k]) bp" for k in 1:length(edges)-1]
    lenticks = x -> _lenlabel(x)
    q = s.series.read_quality
    b = s.series.base_quality
    g = s.series.gc
    charts = _Chart[]
    # drop leading/trailing columns that are zero or missing in every sample
    function trim(x, tips, y)
        # `local`: assigning a name of the enclosing function inside a closure
        # would overwrite it (here `b`, the base-quality series)
        local nz = [any(v -> isfinite(v) && v > 0, view(y, :, j)) for j in axes(y, 2)]
        local first_nz, last_nz = findfirst(nz), findlast(nz)
        first_nz === nothing && return x, tips, y
        local lo, hi = max(first_nz - 1, 1), min(last_nz + 1, length(x))
        return x[lo:hi], tips[lo:hi], y[:, lo:hi]
    end
    x1, t1, y1 = trim(xlen, lentips, L.fraction)
    push!(charts, _Chart("length", "Read length distribution",
                         "Fraction of reads per length bin" * (L.scale === :log ? " (logarithmic bins, 20 per decade)" : ""),
                         x1, L.scale === :log, "Read length", lenticks, t1, y1))
    nzl = [any(v -> isfinite(v) && v > 0, view(L.fraction, :, j)) for j in axes(L.fraction, 2)]
    ya = something(findfirst(nzl), 1); yb = something(findlast(nzl), length(xlen))
    ya = max(ya - 1, 1); yb = min(yb + 1, length(xlen))
    push!(charts, _Chart("yield", "Cumulative yield",
                         "Fraction of all bases in reads at least as long as the bin's lower edge",
                         xlen[ya:yb], L.scale === :log, "Minimum read length", lenticks, ytips[ya:yb], L.yield[:, ya:yb]))
    x3, t3, y3 = trim(Float64.(q.q), ["Q$(k)–$(k + 1)" for k in q.q], q.fraction)
    push!(charts, _Chart("readq", "Read quality",
                         "Fraction of reads by mean quality (error-probability mean, 1-Q bins)",
                         x3, false, "Mean read quality (Phred)", x -> string(Int(round(x))), t3, y3))
    x4, t4, y4 = trim(Float64.(b.q), ["Q$(k)" for k in b.q], b.fraction)
    push!(charts, _Chart("baseq", "Base quality", "Fraction of bases by Phred score",
                         x4, false, "Phred score", x -> string(Int(round(x))), t4, y4))
    x5, t5, y5 = trim(Float64.(g.percent), ["$(k)% GC" for k in g.percent], g.fraction)
    pq = s.series.position_quality
    pe = pq.edges
    xpos = [(pe[k] + pe[k+1] - 1) / 2 for k in 1:length(pe)-1]
    ptips = [pe[k+1] - pe[k] == 1 ? "position $(pe[k])" : "positions $(pe[k])–$(pe[k+1] - 1)" for k in 1:length(pe)-1]
    push!(charts, _Chart("posq", "Quality by position",
                         "Mean Phred score of the bases at each read position (bases pooled within bins); positions " *
                         "covered by fewer than max($(pq.min_bases), $(round(Int, 100 * pq.min_fraction))% of reads) " *
                         "bases are not shown",
                         xpos, false, "Position in read (bp)", lenticks, ptips, pq.mean_quality, :phred))
    push!(charts, _Chart("gc", "Per-read GC content", "Fraction of reads by GC percentage, (G+C)/(A+C+G+T)",
                         x5, false, "GC content (%)", x -> string(Int(round(x))), t5, y5))
    return charts
end

const _FLAG_LABELS = (basic_statistics = "Basic", per_base_quality = "Base Q", per_sequence_quality = "Seq Q",
                      per_base_content = "Content", per_base_n_content = "N", sequence_length_distribution = "Length",
                      adapter_content = "Adapter", overrepresented_sequences = "Overrep.")

function _flag_cell(f)
    f === nothing && return "–"
    out = IOBuffer()
    for (k, lab) in pairs(_FLAG_LABELS)
        v = get(f, string(k), nothing)
        v === nothing && continue
        icon = v == "pass" ? "✓" : v == "warn" ? "!" : v == "fail" ? "✕" : "?"
        print(out, """<span class="flag $(_esc(v))" title="$(_esc(lab)): $(_esc(v))">$(icon) $(_esc(lab))</span>""")
    end
    return String(take!(out))
end

"""
    write_html(io, set::SampleSet; title = "SeqQC multi-sample report")

Write a self-contained HTML report (no external resources). Usually called
through `report(set, "report.html")`.
"""
function write_html(io::IO, s::SampleSet; title::AbstractString = "SeqQC multi-sample report")
    n = length(s)
    charts = _charts(s)
    lines = n <= _MAX_LINE_SAMPLES
    chartdata = []
    body = IOBuffer()
    for c in charts
        println(body, """<section class="card"><h2>$(_esc(c.title))</h2><p class="sub">$(_esc(c.subtitle))</p>""")
        if lines
            px = _line_svg(body, c, 1:n)
            push!(chartdata, (id = c.id, kind = "line", unit = c.unit, px = px, tips = c.xtips, series = nothing,
                              y = [c.y[i, :] for i in 1:n]))
        else
            _heat_svg(body, c, s.samples)
            push!(chartdata, (id = c.id, kind = "heat", unit = c.unit, tips = c.xtips, series = nothing,
                              y = [c.y[i, :] for i in 1:n]))
        end
        println(body, "</section>")
    end
    data = (samples = s.samples, charts = chartdata)
    js = IOBuffer()
    _json(js, data, ())
    jsondata = replace(String(take!(js)), "<" => "\\u003c")

    hasflags = any(!isnothing, s.table.fastqc_flags)
    t = s.table
    println(io, """<!DOCTYPE html><html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$(_esc(title))</title><style>$(_CSS)
$(join((".viz-root .s$(i-1){stroke:$(_CAT_LIGHT[i])} .viz-root .k$(i-1){background:$(_CAT_LIGHT[i])}" for i in 1:min(n, 8)), "\n"))
@media (prefers-color-scheme: dark){ :root:where(:not([data-theme="light"])) .viz-root{
$(join((".s$(i-1){stroke:$(_CAT_DARK[i])} .k$(i-1){background:$(_CAT_DARK[i])}" for i in 1:min(n, 8)), "\n"))}}
</style></head><body><div class="viz-root">
<header><h1>$(_esc(title))</h1>
<p class="meta">$(n) samples · SeqQC $(_esc(VERSION_STRING)) · $(_esc(Libc.strftime("%Y-%m-%d %H:%M", time())))</p></header>""")
    if !isempty(s.warnings)
        println(io, """<details class="warnings"><summary>⚠ $(length(s.warnings)) warning$(length(s.warnings) == 1 ? "" : "s")</summary><ul>""")
        for w in s.warnings
            println(io, "<li>", _esc(w), "</li>")
        end
        println(io, "</ul></details>")
    end
    println(io, """<div class="toolbar"><input id="filter" type="search" placeholder="Filter samples" aria-label="Filter samples">
<button id="clear" type="button">Clear selection</button><span class="hint">Click a row$(lines ? " or a legend entry" : "") to highlight a sample in all charts.</span></div>""")
    # table
    heads = [("Sample", :sample, false), ("Reads", :reads, true), ("Bases", :bases, true),
             ("Median length", :median_length, true), ("Read N50", :n50, true), ("Max length", :max_length, true),
             ("GC %", :gc_percent, true), ("Mean read Q", :mean_read_quality, true),
             ("Reads ≥Q20 %", :percent_reads_q20, true), ("Bases ≥Q30 %", :percent_bases_q30, true),
             ("Warnings", :warnings, true)]
    println(io, """<div class="tablewrap"><table id="summary"><thead><tr>""")
    for (h, _, num) in heads
        print(io, """<th scope="col" class="$(num ? "num" : "")" tabindex="0">$(_esc(h))</th>""")
    end
    hasflags && print(io, """<th scope="col">FastQC flags</th>""")
    println(io, "</tr></thead><tbody>")
    for i in 1:n
        print(io, """<tr data-sample="$(i - 1)" tabindex="0">""")
        for (_, k, num) in heads
            v = t[k][i]
            if k === :sample
                key = lines ? """<i class="key k$(i - 1)"></i>""" : ""
                print(io, """<td data-v="$(_esc(v))">$(key)$(_esc(v))</td>""")
            else
                dv = v isa Real && isfinite(v) ? string(v) : ""
                print(io, """<td class="num" data-v="$(dv)">$(_cell(v; digits = k in (:reads, :bases) ? 0 : 1))</td>""")
            end
        end
        hasflags && print(io, "<td>", _flag_cell(t.fastqc_flags[i]), "</td>")
        println(io, "</tr>")
    end
    println(io, "</tbody></table></div>")
    if lines && n >= 2
        println(io, """<div class="legend" role="list">""")
        for i in 1:n
            println(io, """<button class="lg" type="button" role="listitem" data-sample="$(i - 1)"><i class="key k$(i - 1)"></i>$(_esc(s.samples[i]))</button>""")
        end
        println(io, "</div>")
    end
    println(io, """<div class="grid2">""", String(take!(body)), "</div>")
    println(io, """<footer><p>Definitions: SeqQC <code>docs/METRICS.md</code>. Read quality is the
error-probability mean per read; GC excludes N and IUPAC codes. Distributions are fractions of each
sample's reads or bases, so samples of different size are comparable. Values for every sample are in
the table and in the TSV/JSON outputs of <code>aggregate</code>.</p></footer></div>
<div id="tip" role="tooltip" hidden></div>
<script type="application/json" id="seqqc-data">$(jsondata)</script>
<script>$(_JS)</script></body></html>""")
    return nothing
end

const _CSS = raw"""
.viz-root{color-scheme:light;--surface-1:#fcfcfb;--page:#f9f9f7;--ink:#0b0b0b;--ink2:#52514e;--muted:#898781;
 --grid:#e1e0d9;--axis:#c3c2b7;--border:rgba(11,11,11,0.10);--na:#f0efec;--good:#0ca30c;--warn:#fab219;--crit:#d03b3b;
 font-family:system-ui,-apple-system,"Segoe UI",sans-serif;color:var(--ink);background:var(--page);padding:24px;max-width:1440px;margin:0 auto}
@media (prefers-color-scheme: dark){:root:where(:not([data-theme="light"])) .viz-root{color-scheme:dark;--surface-1:#1a1a19;
 --page:#0d0d0d;--ink:#f0efec;--ink2:#c3c2b7;--muted:#898781;--grid:#2c2c2a;--axis:#383835;--border:rgba(255,255,255,0.10);--na:#383835}}
body{margin:0;background:var(--page)}
h1{font-size:22px;margin:0 0 4px}h2{font-size:15px;margin:0}
.meta,.sub,.hint{color:var(--ink2);font-size:13px;margin:2px 0 0}
.toolbar{display:flex;gap:12px;align-items:center;margin:16px 0 8px;flex-wrap:wrap}
.toolbar input{padding:6px 10px;border:1px solid var(--border);border-radius:6px;background:var(--surface-1);color:var(--ink);min-width:220px}
.toolbar button,.lg{padding:5px 10px;border:1px solid var(--border);border-radius:6px;background:var(--surface-1);color:var(--ink);cursor:pointer;font:inherit;font-size:13px}
.warnings{background:var(--surface-1);border:1px solid var(--border);border-radius:8px;padding:8px 12px;margin-top:12px;font-size:13px}
.warnings ul{margin:6px 0 0;padding-left:20px;max-height:200px;overflow:auto}
.tablewrap{overflow:auto;max-height:420px;border:1px solid var(--border);border-radius:8px;background:var(--surface-1)}
table{border-collapse:collapse;width:100%;font-size:13px}
th,td{padding:6px 10px;border-bottom:1px solid var(--grid);text-align:left;white-space:nowrap}
th{position:sticky;top:0;background:var(--surface-1);color:var(--ink2);font-weight:600;cursor:pointer;user-select:none}
th.num,td.num{text-align:right;font-variant-numeric:tabular-nums}
th[aria-sort="ascending"]::after{content:" ▲"}th[aria-sort="descending"]::after{content:" ▼"}
tbody tr{cursor:pointer}tbody tr:hover{background:var(--na)}tr.selected{outline:2px solid var(--ink2);outline-offset:-2px}
tr.hidden{display:none}
.key{display:inline-block;width:14px;height:3px;border-radius:2px;margin-right:6px;vertical-align:middle}
.flag{display:inline-block;margin-right:6px;font-size:12px;padding:0 4px;border-radius:4px;border:1px solid var(--border)}
.flag.pass::first-letter{color:var(--good)}.flag.warn::first-letter{color:#b07a00}.flag.fail::first-letter{color:var(--crit)}
.legend{display:flex;flex-wrap:wrap;gap:6px;margin:12px 0}
.lg.selected{outline:2px solid var(--ink2)}
.grid2{display:grid;grid-template-columns:repeat(auto-fit,minmax(520px,1fr));gap:16px;margin-top:12px}
.card{background:var(--surface-1);border:1px solid var(--border);border-radius:10px;padding:14px 16px}
svg.chart{width:100%;height:auto;display:block;margin-top:8px;overflow:visible}
.grid{stroke:var(--grid);stroke-width:1}.axis{stroke:var(--axis);stroke-width:1}
.tick{fill:var(--muted);font-size:11px;font-variant-numeric:tabular-nums}.axis-title{fill:var(--ink2);font-size:12px}
.rowlabel{fill:var(--ink2);font-size:10px}
.series{fill:none;stroke-width:2;stroke-linejoin:round;stroke-linecap:round;transition:opacity .15s}
.series.dim,.row.dim{opacity:.15}.series.hidden{display:none}.row.hidden{opacity:.06}
.series.sel{stroke-width:3}
.row.sel .cell{stroke:var(--ink);stroke-width:.6}
.crosshair{stroke:var(--ink2);stroke-width:1}.hit{fill:transparent}
.ramp{display:flex;align-items:center;gap:6px;font-size:11px;color:var(--muted);margin-top:4px}
.ramp .bar{display:flex;height:8px;width:160px;border-radius:2px;overflow:hidden}.ramp i{flex:1}
#tip{position:fixed;pointer-events:none;background:var(--surface-1);color:var(--ink);border:1px solid var(--border);
 border-radius:8px;padding:8px 10px;font:12px system-ui,sans-serif;box-shadow:0 4px 16px rgba(0,0,0,.12);max-width:320px;z-index:10}
#tip .h{color:var(--ink2);margin-bottom:4px}#tip .r{display:flex;gap:8px;align-items:center;white-space:nowrap}
#tip b{font-variant-numeric:tabular-nums;min-width:56px;text-align:right}#tip .r span.n{color:var(--ink2);overflow:hidden;text-overflow:ellipsis}
footer{color:var(--ink2);font-size:12px;margin-top:20px}
"""

const _JS = raw"""
(function(){
const data = JSON.parse(document.getElementById('seqqc-data').textContent);
const tip = document.getElementById('tip');
const rows = Array.from(document.querySelectorAll('#summary tbody tr'));
let selected = null;
const fmt = (v, unit) => (v === null || v === undefined) ? '–' :
  unit === 'phred' ? 'Q' + v.toFixed(1) : unit === 'percent' ? v.toFixed(v >= 10 ? 1 : 2) + '%' :
  (100 * v).toFixed(v >= 0.1 ? 1 : 2) + '%';
function visible(i){ return !rows[i] || !rows[i].classList.contains('hidden'); }
function paint(){
  document.querySelectorAll('[data-sample]').forEach(el => {
    if (el.tagName === 'TR' || el.classList.contains('lg')) {
      el.classList.toggle('selected', selected !== null && +el.dataset.sample === selected); return;
    }
    const i = +el.dataset.sample;
    el.classList.toggle('hidden', !visible(i));
    el.classList.toggle('dim', selected !== null && i !== selected && visible(i));
    el.classList.toggle('sel', selected === i);
  });
}
function select(i){ selected = (selected === i) ? null : i; paint(); }
rows.forEach(r => {
  r.addEventListener('click', () => select(+r.dataset.sample));
  r.addEventListener('keydown', e => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); select(+r.dataset.sample); } });
});
document.querySelectorAll('.lg').forEach(b => b.addEventListener('click', () => select(+b.dataset.sample)));
const clearBtn = document.getElementById('clear');
if (clearBtn) clearBtn.addEventListener('click', () => { selected = null; paint(); });
const filterBox = document.getElementById('filter');
if (filterBox) filterBox.addEventListener('input', e => {
  const q = e.target.value.toLowerCase();
  rows.forEach((r, i) => r.classList.toggle('hidden', q !== '' && !data.samples[i].toLowerCase().includes(q)));
  paint();
});
// sortable table
const ths = Array.from(document.querySelectorAll('#summary thead th'));
ths.forEach((th, col) => {
  const sort = () => {
    const asc = th.getAttribute('aria-sort') !== 'ascending';
    ths.forEach(h => h.removeAttribute('aria-sort'));
    th.setAttribute('aria-sort', asc ? 'ascending' : 'descending');
    const num = th.classList.contains('num');
    const tb = document.querySelector('#summary tbody');
    rows.slice().sort((a, b) => {
      const x = a.children[col].dataset.v ?? a.children[col].textContent, y = b.children[col].dataset.v ?? b.children[col].textContent;
      if (num) { const fx = x === '' ? -Infinity : +x, fy = y === '' ? -Infinity : +y; return asc ? fx - fy : fy - fx; }
      return asc ? x.localeCompare(y, undefined, {numeric: true}) : y.localeCompare(x, undefined, {numeric: true});
    }).forEach(r => tb.appendChild(r));
  };
  th.addEventListener('click', sort);
  th.addEventListener('keydown', e => { if (e.key === 'Enter') sort(); });
});
// tooltips
function row(name, value, key){
  const r = document.createElement('div'); r.className = 'r';
  if (key !== undefined && key !== null) { const k = document.createElement('i'); k.className = 'key k' + key; r.appendChild(k); }
  const b = document.createElement('b'); b.textContent = value; r.appendChild(b);
  const n = document.createElement('span'); n.className = 'n'; n.textContent = name; r.appendChild(n);
  return r;
}
function show(ev, head, rowsEl){
  tip.replaceChildren();
  const h = document.createElement('div'); h.className = 'h'; h.textContent = head; tip.appendChild(h);
  rowsEl.forEach(r => tip.appendChild(r));
  tip.hidden = false;
  const x = Math.min(ev.clientX + 14, window.innerWidth - tip.offsetWidth - 8);
  const y = Math.min(ev.clientY + 14, window.innerHeight - tip.offsetHeight - 8);
  tip.style.left = x + 'px'; tip.style.top = y + 'px';
}
function hide(){ tip.hidden = true; }
data.charts.forEach(c => {
  const svg = document.querySelector('svg[data-chart="' + c.id + '"]');
  if (!svg) return;
  if (c.kind === 'line') {
    const ch = svg.querySelector('.crosshair'), hit = svg.querySelector('.hit');
    hit.addEventListener('pointermove', ev => {
      const pt = svg.createSVGPoint(); pt.x = ev.clientX; pt.y = ev.clientY;
      const p = pt.matrixTransform(svg.getScreenCTM().inverse());
      let j = 0, best = Infinity;
      c.px.forEach((x, k) => { const d = Math.abs(x - p.x); if (d < best) { best = d; j = k; } });
      ch.setAttribute('x1', c.px[j]); ch.setAttribute('x2', c.px[j]); ch.setAttribute('visibility', 'visible');
      const items = [];
      c.y.forEach((ys, i) => { if (c.series || visible(i)) items.push([ys[j], i]); });
      if (!c.series) items.sort((a, b) => (b[0] ?? -1) - (a[0] ?? -1));
      show(ev, c.tips[j], items.map(([v, i]) => row(c.series ? c.series[i] : data.samples[i], fmt(v, c.unit),
                                                    c.keys ? c.keys[i] : i)));
    });
    hit.addEventListener('pointerleave', () => { ch.setAttribute('visibility', 'hidden'); hide(); });
  } else {
    svg.addEventListener('pointermove', ev => {
      const t = ev.target;
      if (!t.classList || !t.classList.contains('cell')) { hide(); return; }
      const i = +t.parentNode.dataset.sample, j = +t.dataset.c;
      show(ev, c.tips[j], [row(data.samples[i], fmt(c.y[i][j], c.unit))]);
    });
    svg.addEventListener('pointerleave', hide);
    svg.addEventListener('click', ev => { const g = ev.target.closest && ev.target.closest('.row'); if (g) select(+g.dataset.sample); });
  }
});
paint();
})();
"""
