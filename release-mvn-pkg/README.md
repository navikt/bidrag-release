# bidrag-actions/release-mvn-pkg

En github action som vil legge en ny maven artefakt i github packages for navikt.

Det forventes at steget blir kjørt på en linux/unix maskin og har installert maven.
Prosjektet må derfor også bygges med maven.

Ingen input er forventet, men det er forventet at prosjektet har blitt klargjort
for en release. Det som blir utført er en `mvn deploy` og etterpå en `mvn versions:set`
med den nye snapshot versjonen
