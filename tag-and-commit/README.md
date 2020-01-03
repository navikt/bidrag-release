# bidrag-actions/tag-and-commit

This action will create a tag, commit changed repository files, and push to origin

Requires a runner with node and ncc installed. Also the running environment must
be able to execute bash scripts.

The action requires a file containing the tag to push, the massage of the commit,
and the pattern to use with git tag; see action.yml.

if a file containing the content of the tag is present, the content will replace
{} from the commit message provided.
