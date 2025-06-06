# BVerfG RAG Corpus - Einfache Pipeline

# Output-Ordner erstellen
dir.create("output", showWarnings = FALSE)

# Konfiguration laden
config <- RcppTOML::parseTOML("config.toml")

# Pipeline ausführen
cat("🚀 Starte BVerfG RAG Corpus Pipeline...\n")

rmarkdown::render("pipeline.Rmd",
                  output_file = file.path("output",
                                          paste0(config$project$shortname,
                                                 "_",
                                                 Sys.Date(),
                                                 "_RAG_Report.html")))

cat("✅ Pipeline abgeschlossen! Ergebnisse in output/ Ordner.\n")

