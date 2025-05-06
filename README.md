# Overview

This is meant to be a general framework for evaluating AI against devops and SRE tasks.  There is some nuance to this domain that's worth mentioning versus some of the standard coding benchmarks, namely:

* Lack of mechanical verification - A coding benchmark can be compiled and tested with example input.  There is no equivalent for devops, so the structure of the evaluation is going to have to be more of a qualitative grading.
* Cost of testing - Devops usually involves creation and mutation of infrastructure in the cloud.  Each of these has significant time and dollar cost, and so the benchmark should, as best as possible, be built in a way to simplify that
* Heterogeneity - Most operations are heavily based on tribal knowledge that is nonstandardized across companies.  For problems that require this, it's ok to assume the necessary integrations exist - provided there's a documented integration path.

For each test case, they will have the following schema:


```yaml
name: string # short name of the case
description: string # a longer description explaining the case
category: kubernetes | terraform | application | policy # what sort of issue this is
difficulty: low | medium | high
successCriteria: [string] # a list of grading criteria an evaluator should use to determine the full grade
```

As far as the evaluation mechanism, each test case will have a result schema as follows:

```yaml
name: string # the name of the test case
description: string # a full description of the issue being troubleshooted
grade: integer # 0-4 grade
resultUrl: string # url to a video of the run for confirmation of the grade
gitLocation: 
  url: string # url to the repo this test was implemented in
  location: string # file/folder location in git of the code implementing it
prUrl: string # a pull request link in the event the AI was able to fix the issue
```

The idea behind having the associated urls is it can not only document how the AI did, but also allow third parties to confirm or dispute the grade given.  This allows for a consensus to form given the inherent vagueness of the space.

The grading schema will be 0-4 and will be as follows:

* 0 - failing grade:  the AI gave a completely incorrect answer to the issue
* 1 - not informative:  the ai gave no insight, but also didn't misdirect the user in any way
* 2 - partially informative:  the ai gave a correct summary of the issue, but there was still significant human effort required
* 3 - informative: the AI does a full root cause analysis of the issue, but doesn't actually fix it
* 4 - autonomous: the AI not only RCAs the issue, but generates a fully correct fix, ideally as a pull request.  The system is able to fully fix the issue with simple human approval.

## Benchmark Cases

The full set of benchmark cases to evaluate will live in

```
benchmark/
- {case}.yaml
```

And each run should attempt to perform each element of the benchmark.

## Historical Evaluations

Historical evaluations will be in the folder structure:

```
evaluations/
- {product}/
- - {date}.yaml # a yaml list of all the test case schemas above
```

And the full benchmark can simply be computed by summing the grades within the single date run of the benchmark