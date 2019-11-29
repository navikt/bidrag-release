# bidrag-actions
Github Actions spesialisert for team bidrag

Hovedregel for design:
Alt blir utført av bash-scripter slik at det enkelt kan testes på reell kodebase uten å måtte bygge med github. Alle "actions" som trenger input får
dette som form av tekst skrevet til enkle filer på filsystemet med navn lik `.filnavn`

Unntakene til dette er prosessering som krever autentisering, eks: `GITHUB_TOKEN`.
