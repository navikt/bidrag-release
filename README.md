# bidrag-relase
Github Actions for release av github artifact, spesialisert for team bidrag

### Continuous integration
![](https://github.com/navikt/bidrag-release/workflows/build%20actions/badge.svg)

### Hovedregel for design:
Alt blir utført av bash-scripter slik at det enkelt kan testes på reell kodebase uten å måtte bygge med github. Noen "actions" produserer "output" som
må settes som inputs til hver action andre actions (se `action.yml` for en action)

Man må også angi miljøvariabler for autentisering (når action trenger dette), eks: `GITHUB_TOKEN`.

Andre sider ved design av disse "actions", er at de er laget for å kjøre sammen. Dvs. at enkelte actions lager output som kan brukes av andre "actions". 

#### Sterke koblinger mellom "actions":

Noen av "actions" har sterke koblinger i form av at de produserer outputs som påvirker hvordan andre actions oppfører seg.

produserer output     | output                 | actions som bruker output
----------------------|------------------------|--------------------------
`prepare-mvn-pkg`     | `release_version`      | `mvn-github-pkg`, `verify-auto-release`, `tag-n-commit-release`
`prepare-mvn-pkg`     | `new_snapshot_version` | `mvn-pkg`, `verify-auto-release`
`verify-auto-deployg` | `is_release_candidate` | `mvn-pkg`, `git-tag-n-commit-release`

Det er lagt inn en workflow for å bygge alle actions med npm og ncc. Derfor er det bare filene `/<action>/index.js` og `/<action>/<bash>.sh` som skal
endres når man skal forandre logikk i "action".

### Changelog

Versjon | Endringstype | Beskrivelse
--------|--------------|------------
v3.0.1  | Endring      | `tag-n-commit`: will commit tag and set next SNAPSHOT version when `new_snapshot_version` is provided
v3.0.1  | Endring      | `mvn-githu-pkg`: will not set next SNAPSHOT version if `ìs_commit_tag`
v3.0.0  | nytt repo    | trukket ut kode til nytt repo og endret navn på action mapper
v2.0.3  | Endret       | `release-verify-auto-deploy`: git status message is filtered with focus on new, modified, or deleted files
v2.0.2	| Endret       | `release-tag-n-commit-deploy`: internal refac (fix)
v2.0.1  | Endret       | logging and use of git
v2      | Endret       | actions generate and use outputs as inputs
v1      | Endret       | `release-mvn-package`: ommit " when doing logging with the echo command 
v1      | Endret       | `release-prepare-mvn-package`: ommit " when doing logging with the echo command 
v1      | Endret       | `release-verify-auto-deploy`: ommit " when doing logging with the echo command 
