# bidrag-actions
Github Actions spesialisert for team bidrag

### Hovedregel for design:
Alt blir utført av bash-scripter slik at det enkelt kan testes på reell kodebase uten å måtte bygge med github. Alle "actions" som trenger input får
dette som form av tekst skrevet til enkle filer på filsystemet og dette navngis med miljøvariabler til hver action

Utenom miljøvariabler for filnavn, så finnes også miljøvariabler for autentisering (når action trenger dette), eks: `GITHUB_TOKEN`.

### Continuous integration
![](https://github.com/navikt/bidrag-commons/workflows/continious%20integration/badge.svg)

Det er lagt inn en workflow for å bygge alle actions med npm og ncc når master branch kjører. Derfor er det bare filene `/<action>/index.js` og 
`<action>/<bash>.sh` som skal endres.
