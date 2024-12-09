#!/usr/bin/env cwl-runner
arguments:
- -p
- input_stac_collection_file
- $(inputs.download_dir.path)/stage-in-results.json
- -p
- output_stac_catalog_dir
- $(runtime.outdir)/process_output
baseCommand:
- papermill
- /home/jovyan/process.ipynb
- --cwd
- /home/jovyan
- process_output/output_nb.ipynb
- -f
- /tmp/inputs.json
- -k
- python3
class: CommandLineTool
cwlVersion: v1.2
inputs:
  download_dir: Directory
  output_collection:
    default: urn:nasa:unity:emit:dev:emit_ghg_test___1
    type: string
outputs:
  process_output_dir:
    outputBinding:
      glob: $(runtime.outdir)/process_output
    type: Directory
  process_output_nb:
    outputBinding:
      glob: $(runtime.outdir)/process_output/output_nb.ipynb
    type: File
requirements:
  DockerRequirement:
    dockerPull: 463470953872.dkr.ecr.us-west-2.amazonaws.com/emit/ghg_test:9dea37f2
  InitialWorkDirRequirement:
    listing:
    - entry: $(inputs)
      entryname: /tmp/inputs.json
    - entry: '$({class: ''Directory'', listing: []})'
      entryname: process_output
      writable: true
  InlineJavascriptRequirement: {}
  InplaceUpdateRequirement:
    inplaceUpdate: true
  NetworkAccess:
    networkAccess: true
  ShellCommandRequirement: {}
stdout: stdout.txt
