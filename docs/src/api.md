# API

```@meta
CurrentModule = SeqQC
```

```@docs
SeqQC
```

## Analysis

```@docs
analyze
default_metrics
QCResult
InputInfo
SeqQCInputError
yield_by_length
```

## Metrics

```@docs
ReadLength
BaseComposition
QualityDistribution
QualityVsLength
PerPositionStats
```

## Writing a metric

```@docs
AbstractQCMetric
ReadView
ReadSummary
init_state
update!
finalize_metric
metric_name
requirements
memory_complexity
definition
SeqQC.metric_warnings
```

## Reports

```@docs
report
to_json
write_json
read_json
aggregate
SampleSet
sample_name
write_table
SeqQC.write_html
```

## FastQC compatibility

```@docs
SeqQC.FastQC
SeqQC.FastQC.metrics
SeqQC.FastQC.modules
SeqQC.FastQC.flags
SeqQC.FastQC.encoding
SeqQC.FastQC.base_groups
SeqQC.FastQC.length_bins
SeqQC.FastQC.basic_statistics
SeqQC.FastQC.per_base_quality
SeqQC.FastQC.per_sequence_quality
SeqQC.FastQC.per_base_content
SeqQC.FastQC.per_sequence_gc
SeqQC.FastQC.per_base_n
SeqQC.FastQC.length_distribution
SeqQC.FastQC.adapter_content
SeqQC.FastQC.overrepresented
SeqQC.FastQC.GCModel
SeqQC.FastQC.AdapterContent
SeqQC.FastQC.DEFAULT_ADAPTERS
SeqQC.FastQC.Overrepresented
SeqQC.FastQC.read_contaminants
write_fastqc_data
write_fastqc_summary
```

## Truncation for DADA2 and vsearch

```@docs
truncation_profile
TruncationProfile
kept_reads
suggest_truncation
TruncationSuggestion
truncation_commands
```

## Command line

```@docs
SeqQC.main
```
