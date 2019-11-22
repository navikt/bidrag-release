# bidrag-actions/release-mvn-pkg

En github action som vil legge en ny maven artefakt i github package registry 

Det forventes at steget blir kjørt på en linux/unix maskin og har installert maven.
Prosjektet må derfor også bygges med maven.

Ingen input er forventet. Steget returnerer ikke "outputs", men fila `pom.xml` (project
object model)vil være endret med den nye versjonen (og det er IKKE gjort noen commit i
git-historikken)
