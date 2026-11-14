# HTML page for a TruncationSuggestion: reads (or pairs) kept by truncation
# length for every maxEE (line chart, suggestion marked), retained bases
# (single-end) or a heatmap of pairs kept over (truncLen R1, truncLen R2) with
# the overlap constraint (paired-end), the alternatives and the commands.
# Self-contained; styles, palette and tooltips of the other SeqQC pages.

const _TRUNC_HEAT_CELLS = 50             # at most this many cells per heatmap axis

_ee_label(e) = "maxEE " * _rnum(e)

function _trunc_heat_svg(io, s::TruncationSuggestion, k::Int)
    p = s.profile
    t1, t2 = size(p.kept, 1), size(p.kept, 2)
    lo1, lo2 = _lowest_len(p, 1, 0), _lowest_len(p, 2, 0)
    (lo1 > t1 || lo2 > t2) && return false
    g = max(1, cld(max(t1 - lo1 + 1, t2 - lo2 + 1), _TRUNC_HEAT_CELLS))
    W, H, ML, MR, MT, MB = _W, 420, _ML, _MR, _MT, _MB
    pw, ph = W - ML - MR, H - MT - MB
    span1, span2 = t1 - lo1 + g, t2 - lo2 + g
    sx(L) = ML + (L - lo1) / span1 * pw
    sy(L) = MT + ph - (L - lo2) / span2 * ph
    need = s.amplicon_length + s.min_overlap
    r(x) = round(x; digits = 1)
    println(io, """<svg class="chart heat2" viewBox="0 0 $W $H" role="img" aria-label="Pairs kept by truncation lengths" data-chart="trunc_heat" data-reads="$(p.reads)" data-amp="$(s.amplicon_length)">""")
    println(io, """<rect x="$ML" y="$MT" width="$pw" height="$ph" fill="var(--surface-1)" stroke="var(--grid)"/>""")
    for L1 in lo1:g:t1, L2 in lo2:g:t2
        n = p.kept[L1, L2, k]
        n > 0 || continue
        v = n / p.reads
        fill = _SEQ_BLUE[clamp(ceil(Int, v * length(_SEQ_BLUE)), 1, length(_SEQ_BLUE))]
        off = L1 + L2 < need ? " off" : ""
        print(io, """<rect class="cell$(off)" x="$(r(sx(L1)))" y="$(r(sy(L2 + g)))" width="$(r(pw * g / span1 + 0.3))" height="$(r(ph * g / span2 + 0.3))" fill="$fill" data-a="$L1" data-b="$L2" data-n="$n"/>""")
    end
    println(io)
    # overlap constraint L1 + L2 = need, clipped to the plot
    a1, b1 = max(lo1, need - (t2 + g)), min(t1 + g, need - lo2)
    if a1 < b1
        println(io, """<line class="constraint" x1="$(r(sx(a1)))" y1="$(r(sy(need - a1)))" x2="$(r(sx(b1)))" y2="$(r(sy(need - b1)))"/>""")
    end
    c1 = _Chart("", "", "", Float64[lo1, t1], false, "", _lenlabel, String[], zeros(1, 2))
    c2 = _Chart("", "", "", Float64[lo2, t2], false, "", _lenlabel, String[], zeros(1, 2))
    for t in _xticks(c1)
        x = r(sx(t) + pw / span1 / 2)
        println(io, """<line class="axis" x1="$x" x2="$x" y1="$(MT + ph)" y2="$(MT + ph + 4)"/><text class="tick" x="$x" y="$(MT + ph + 16)" text-anchor="middle">$(Int(t))</text>""")
    end
    for t in _xticks(c2)
        y = r(sy(t) - ph / span2 / 2)
        println(io, """<line class="axis" x1="$(ML - 4)" x2="$ML" y1="$y" y2="$y"/><text class="tick" x="$(ML - 6)" y="$(r(y + 4))" text-anchor="end">$(Int(t))</text>""")
    end
    println(io, """<text class="axis-title" x="$((ML + W - MR) ÷ 2)" y="$(H - 4)" text-anchor="middle">truncLen R1 (bp)</text>""",
            """<text class="axis-title" x="12" y="$(MT + ph ÷ 2)" text-anchor="middle" transform="rotate(-90 12 $(MT + ph ÷ 2))">truncLen R2 (bp)</text>""")
    L1, L2 = s.trunc_len
    cx, cy = r(sx(L1) + pw / span1 / 2), r(sy(L2) - ph / span2 / 2)
    println(io, """<circle class="sugg" cx="$cx" cy="$cy" r="5"/>""",
            cx > W - 170 ? """<text class="marker-label" x="$(r(cx - 9))" y="$(r(cy - 7))" text-anchor="end">suggested c($(L1), $(L2))</text>""" :
                           """<text class="marker-label" x="$(r(cx + 9))" y="$(r(cy - 7))">suggested c($(L1), $(L2))</text>""")
    println(io, "</svg>")
    println(io, """<div class="ramp"><span>0%</span><span class="bar">""",
            join(("""<i style="background:$c"></i>""" for c in _SEQ_BLUE)), """</span><span>100%</span>""",
            """<span class="lgs" style="margin-left:16px"><i class="dash"></i>L1 + L2 = $(need) (fragment $(s.amplicon_length) + overlap $(s.min_overlap)); faded cells: less overlap</span></div>""")
    return true
end

"""
    write_html(io, s::TruncationSuggestion; title = nothing)

HTML page of a truncation suggestion (usually via `report(s, "x.html")`): reads
or pairs kept by truncation length for every `maxEE`, the retained bases
(single-end) or a heatmap of pairs kept over both truncation lengths
(paired-end), the alternatives, the commands and the warnings.
"""
function write_html(io::IO, s::TruncationSuggestion; title = nothing)
    p = s.profile
    what = p.paired ? "pairs" : "reads"
    title = something(title, "SeqQC truncation — " * join(basename.(p.files), " + "))
    K = length(p.max_ee)
    k = findfirst(==(s.max_ee), p.max_ee)
    names = _ee_label.(p.max_ee)
    keys = collect(0:K-1)
    chartdata = Any[]
    body = IOBuffer()
    sugg = p.paired ? "c($(s.trunc_len[1]), $(s.trunc_len[2]))" : string(s.trunc_len[1])
    legend() = println(body, """<div class="legend static">""",
        join(("""<span class="lgs"><i class="key k$(i - 1)"></i>$(_esc(n))$(i == k ? " (suggestion)" : "")</span>""" for (i, n) in enumerate(names))),
        "</div>")
    if !p.paired
        lo, top = _lowest_len(p, 1, 0), size(p.kept, 1)
        if lo <= top
            Ls = collect(lo:top)
            y = Float64[p.kept[L, j] / p.reads for j in 1:K, L in Ls]
            tips = ["truncLen = $(L)" for L in Ls]
            println(body, """<section class="card"><h2>Reads kept by truncation length</h2><p class="sub">Share of the $(_commas(p.reads)) reads that DADA2's filterAndTrim keeps with truncLen = x, one line per maxEE; dashed line: the suggestion</p>""")
            c = _Chart("trunc_kept", "Reads kept", "", Float64.(Ls), false, "truncLen (bp)", _lenlabel, tips, y)
            px = _line_svg(body, c, 1:K; attr = "data-series", marker = s.trunc_len[1], marker_label = "suggested $(sugg)")
            push!(chartdata, (id = c.id, kind = "line", unit = :fraction, px = px, tips = tips, series = names, keys = keys,
                              y = [y[j, :] for j in 1:K]))
            legend()
            println(body, "</section>")
            b = Float64[p.kept[L, j] * (L - p.trim_left[1]) for j in 1:K, L in Ls]
            bmax = maximum(b)
            bmax > 0 && (b ./= bmax)
            println(body, """<section class="card"><h2>Retained bases</h2><p class="sub">Reads kept × (truncLen − trimLeft), relative to the largest value over all maxEE; the suggestion maximises it for the chosen maxEE</p>""")
            c = _Chart("trunc_bases", "Retained bases", "", Float64.(Ls), false, "truncLen (bp)", _lenlabel, tips, b)
            px = _line_svg(body, c, 1:K; attr = "data-series", marker = s.trunc_len[1], marker_label = "suggested $(sugg)")
            push!(chartdata, (id = c.id, kind = "line", unit = :fraction, px = px, tips = tips, series = names, keys = keys,
                              y = [b[j, :] for j in 1:K]))
            legend()
            println(body, "</section>")
        end
    else
        need = s.amplicon_length + s.min_overlap
        lo1, lo2 = _lowest_len(p, 1, 0), _lowest_len(p, 2, 0)
        L1s = [L1 for L1 in lo1:size(p.kept, 1) if max(lo2, need - L1) <= size(p.kept, 2)]
        if !isempty(L1s)
            L2s = [max(lo2, need - L1) for L1 in L1s]
            y = Float64[p.kept[a, b, j] / p.reads for j in 1:K, (a, b) in zip(L1s, L2s)]
            tips = ["truncLen = c($(a), $(b)) · overlap $(a + b - s.amplicon_length)" for (a, b) in zip(L1s, L2s)]
            println(body, """<section class="card"><h2>Pairs kept with the required overlap</h2><p class="sub">Share of the $(_commas(p.reads)) pairs kept for each R1 truncation with the shortest R2 truncation that leaves $(s.min_overlap) bases of overlap on a $(s.amplicon_length) bp fragment; one line per maxEE</p>""")
            c = _Chart("trunc_kept", "Pairs kept", "", Float64.(L1s), false, "truncLen R1 (bp); R2 = $(need) − R1", _lenlabel, tips, y)
            px = _line_svg(body, c, 1:K; attr = "data-series", marker = s.trunc_len[1], marker_label = "suggested $(sugg)")
            push!(chartdata, (id = c.id, kind = "line", unit = :fraction, px = px, tips = tips, series = names, keys = keys,
                              y = [y[j, :] for j in 1:K]))
            legend()
            println(body, "</section>")
        end
        println(body, """<section class="card"><h2>Pairs kept by both truncation lengths ($(_esc(_ee_label(s.max_ee))))</h2><p class="sub">Each cell: share of pairs kept with truncLen = c(R1, R2)$(size(p.kept, 1) - lo1 + 1 > _TRUNC_HEAT_CELLS ? ", sampled every few bp (lower-left corner of the cell)" : "")</p>""")
        _trunc_heat_svg(body, s, k)
        println(body, "</section>")
    end

    js = IOBuffer()
    _json(js, (samples = String[], charts = chartdata), ())
    jsondata = replace(String(take!(js)), "<" => "\\u003c")
    cmds = truncation_commands(s)
    println(io, """<!DOCTYPE html><html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$(_esc(title))</title><style>$(_CSS)$(_SINGLE_CSS)$(_TRUNC_CSS)
$(join((".viz-root .s$(i-1){stroke:$(_CAT_LIGHT[i])} .viz-root .k$(i-1){background:$(_CAT_LIGHT[i])}" for i in 1:8), "\n"))
@media (prefers-color-scheme: dark){ :root:where(:not([data-theme="light"])) .viz-root{
$(join((".s$(i-1){stroke:$(_CAT_DARK[i])} .k$(i-1){background:$(_CAT_DARK[i])}" for i in 1:8), "\n"))}}
.viz-root .s$(k - 1){stroke-width:3}
</style></head><body><div class="viz-root">
<header><h1>$(_esc(title))</h1>
<p class="meta">$(_esc(join(p.files, " + "))) · $(p.paired ? "paired-end" : "single-end") · trimLeft $(_esc(join(p.trim_left, "/"))) · truncQ $(p.trunc_q) ·
maxN $(p.max_n) · minLen $(p.min_len) · Phred+$(p.phred_offset) · SeqQC $(_esc(VERSION_STRING)) · $(_esc(Libc.strftime("%Y-%m-%d %H:%M", time())))</p></header>""")
    println(io, """<details class="warnings" open><summary>⚠ $(length(s.warnings)) note$(length(s.warnings) == 1 ? "" : "s")</summary><ul>""")
    foreach(w -> println(io, "<li>", _esc(w), "</li>"), s.warnings)
    println(io, "</ul></details>")
    println(io, """<div class="tiles">""")
    _tile(io, "Suggested truncLen", sugg; note = "bp")
    _tile(io, "maxEE", _rnum(s.max_ee))
    _tile(io, p.paired ? "Pairs kept" : "Reads kept", _commas(s.kept); note = "of " * _commas(p.reads))
    _tile(io, "Kept", string(round(100 * s.fraction; digits = 1), "%"))
    s.overlap === nothing || _tile(io, "Expected overlap", string(s.overlap); note = "bp, fragment $(s.amplicon_length) bp")
    _tile(io, "Longest read", join(p.max_length, " / "); note = "bp")
    println(io, "</div>")
    println(io, """<div class="grid2">""", String(take!(body)), "</div>")
    println(io, """<div class="grid2"><section class="card"><h2>Best truncation for each maxEE</h2><p class="sub">$(_esc(s.criterion))</p>
<div class="tablewrap"><table><thead><tr><th>maxEE</th><th class="num">truncLen</th><th class="num">$(what) kept</th><th class="num">%</th>$(p.paired ? "<th class=\"num\">overlap</th>" : "")<th class="num">without truncLen</th></tr></thead><tbody>""")
    for a in s.alternatives
        j = findfirst(==(a.max_ee), p.max_ee)
        println(io, "<tr", a.max_ee == s.max_ee ? " class=\"selected\"" : "", "><td><i class=\"key k", j - 1, "\"></i>", _rnum(a.max_ee),
                "</td><td class=\"num\">", join(a.trunc_len, ", "), "</td><td class=\"num\">", _commas(a.kept), "</td><td class=\"num\">",
                round(100 * a.fraction; digits = 1), "</td>", p.paired ? "<td class=\"num\">$(a.overlap)</td>" : "",
                "<td class=\"num\">", _commas(p.kept_untruncated[j]), "</td></tr>")
    end
    println(io, """</tbody></table></div></section>
<section class="card"><h2>Commands</h2><p class="sub">File names are placeholders; PhiX removal (rm.phix) is not part of the prediction</p>
<h3>R dada2</h3><pre><code>$(_esc(cmds.dada2_r))</code></pre>
<h3>DADA2.jl</h3><pre><code>$(_esc(cmds.dada2_jl))</code></pre>
<h3>vsearch (not validated)</h3><pre><code>$(_esc(cmds.vsearch))</code></pre></section></div>""")
    println(io, """<footer><p>Filter rules and suggestion: SeqQC <code>docs/src/TRUNCATION.md</code>. The counts are exact for DADA2's filter;
the choice is a heuristic. All values are also in the JSON report (<code>report(s, "x.json")</code>).</p></footer></div>
<div id="tip" role="tooltip" hidden></div>
<script type="application/json" id="seqqc-data">$(jsondata)</script>
<script>$(_JS)</script><script>$(_TRUNC_JS)</script></body></html>""")
    return nothing
end

const _TRUNC_CSS = raw"""
h3{font-size:13px;margin:12px 0 4px;color:var(--ink2)}
pre{background:var(--na);border-radius:6px;padding:8px 10px;white-space:pre-wrap;word-break:break-word;margin:0}
.heat2 .cell.off{opacity:.35}
.heat2 .constraint{stroke:var(--ink);stroke-width:1.5;stroke-dasharray:5 4}
.heat2 .sugg{fill:var(--ink);stroke:var(--surface-1);stroke-width:2}
.heat2 .cell:hover{stroke:var(--ink);stroke-width:1}
.dash{display:inline-block;width:18px;height:0;border-top:2px dashed var(--ink);margin-right:6px;vertical-align:middle}
tr.selected td{font-weight:600}
"""

const _TRUNC_JS = raw"""
(function(){
const svg = document.querySelector('svg.heat2'), tip = document.getElementById('tip');
if (!svg) return;
const reads = +svg.dataset.reads, amp = +svg.dataset.amp;
svg.addEventListener('pointermove', ev => {
  const t = ev.target;
  if (!t.classList || !t.classList.contains('cell')) { tip.hidden = true; return; }
  const a = +t.dataset.a, b = +t.dataset.b, n = +t.dataset.n;
  tip.replaceChildren();
  const h = document.createElement('div'); h.className = 'h';
  h.textContent = 'truncLen = c(' + a + ', ' + b + ') · overlap ' + (a + b - amp); tip.appendChild(h);
  const r = document.createElement('div'); r.className = 'r';
  const v = document.createElement('b'); v.textContent = (100 * n / reads).toFixed(1) + '%'; r.appendChild(v);
  const s = document.createElement('span'); s.className = 'n'; s.textContent = n.toLocaleString('en') + ' pairs kept'; r.appendChild(s);
  tip.appendChild(r);
  tip.hidden = false;
  tip.style.left = Math.min(ev.clientX + 14, window.innerWidth - tip.offsetWidth - 8) + 'px';
  tip.style.top = Math.min(ev.clientY + 14, window.innerHeight - tip.offsetHeight - 8) + 'px';
});
svg.addEventListener('pointerleave', () => { tip.hidden = true; });
})();
"""
