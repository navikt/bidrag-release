# bidrag-actions
Github Actions spesialisert for team bidrag

Hovedregel for design:
Alt blir utført av bash-scripter slik at det enkelt kan testes på reell kodebase uten å måtte bygge med github. Alle "actions" som trenger input får
dette som form av tekst skrevet til enkle filer på filsystemet (`.filnavn`)

Unntakene til dette er "statisk" input som ikke kan hentes ut av kodebasen, eks: `GITHUB_TOKEN` og navnet på changelog-fil for
`bidrag-actions/release-verify-auto-deploy`
