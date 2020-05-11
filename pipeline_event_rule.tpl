{
  "source": [
    "aws.codepipeline"
  ],
  "detail-type": [
    "CodePipeline Pipeline Execution State Change"
  ],
  "detail": {
    "pipeline": [
        "${codepipeline_name}"
    ],
    "state" : ["${state}"]
  }
}