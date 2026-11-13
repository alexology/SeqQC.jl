# The metric protocol. A metric is a small immutable configuration object; all
# mutable data live in its state, so states of the same metric are independent
# and can be merged (parallel reduction, multi-file aggregation).

"""
    AbstractQCMetric

Supertype of all QC metrics. A metric `M` implements:

- `init_state(m::M)`: a fresh, empty accumulator;
- `update!(state, read::ReadView)`: add one read;
- `Base.merge!(dst, src)`: add the reads of `src` to `dst` (same metric and
  configuration); merging must give the same result as streaming the reads of
  both states through one accumulator (floating-point sums may differ by
  rounding, see `docs/src/METRICS.md`);
- `finalize_metric(state)`: an immutable result (`NamedTuple` or struct);
- `metric_name(m)`: a unique `Symbol` used as key in [`QCResult`](@ref).

Optional traits, with defaults: [`requirements`](@ref) (`(:sequence,)`),
[`memory_complexity`](@ref) (`:unspecified`), [`definition`](@ref) (`""`).
Custom metrics need no change to the engine: pass them to
`analyze(path; metrics=[...])`.
"""
abstract type AbstractQCMetric end

"""
    init_state(metric) -> state

Return an empty accumulator for `metric`.
"""
function init_state end

"""
    update!(state, read::ReadView) -> state

Add `read` to the accumulator `state`.
"""
function update! end

"""
    finalize_metric(state)

Turn an accumulator into an immutable result. Must not modify `state`.
"""
function finalize_metric end

"""
    metric_name(metric) -> Symbol

Key of the metric in the results; must be unique within one analysis.
"""
function metric_name end

"""
    requirements(metric) -> Tuple of Symbols

Input data the metric needs: any of `:sequence`, `:quality`, `:identifier`.
FASTQ input provides all three. The engine rejects a metric whose requirements
the input cannot satisfy instead of computing it on missing data.
"""
requirements(::AbstractQCMetric) = (:sequence,)

"""
    memory_complexity(metric) -> Symbol

Documentation trait describing how the state grows: `:constant`,
`:distinct_lengths` (one counter per distinct read length) or `:unspecified`.
"""
memory_complexity(::AbstractQCMetric) = :unspecified

"""
    definition(metric) -> String

Short definition of the computed quantities, stored with the results.
"""
definition(::AbstractQCMetric) = ""

const INPUT_FIELDS = Dict(:fastq => (:sequence, :quality, :identifier))
