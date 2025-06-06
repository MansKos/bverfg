# BVerfG RAG Corpus

## Überblick

Schlanke, RAG-optimierte Version des **Corpus der Entscheidungen des Bundesverfassungsgerichts**. Diese Pipeline extrahiert BVerfG-Entscheidungen in einem für Retrieval-Augmented Generation (RAG) optimierten Format.

## 🎯 Für RAG optimiert

- **Kompakte Datenstruktur**: Nur relevante Metadaten und Volltext
- **Mehrere Exportformate**: CSV, RDS, JSON
- **Bereinigte Texte**: Entfernung von Formatierungsresten
- **Chunking-bereit**: Geeignet für Embedding-Modelle
- **⚡ Inkrementelle Updates**: Nur neue Entscheidungen werden heruntergeladen

## 🚀 Schnellstart

### Voraussetzungen
- R (≥ 4.0)
- Internet-Verbindung

### Installation
```bash
git clone https://github.com/MansKos/bverfg.git
cd bverfg
```

### Ausführung
```r
# R-Konsole
source("run_project.R")
```

## 📊 Ausgabe

Die Pipeline erstellt drei Dateiformate im `output/` Ordner:

- **`bverfg_rag_corpus.csv`** - CSV für allgemeine Nutzung
- **`bverfg_rag_corpus.rds`** - R-Format (kompakt, schnell)
- **`bverfg_rag_corpus.json`** - JSON für Python/JavaScript

## 🏗️ Datenstruktur

Jede Entscheidung enthält:
```
id              # Eindeutige Kennung
title           # Titel der Entscheidung
date            # Entscheidungsdatum
content         # Volltext (bereinigt)
url             # Original-URL
aktenzeichen    # Aktenzeichen
gericht         # Gericht
```

## 💡 RAG-Integration

### Python-Beispiel
```python
import pandas as pd
from sentence_transformers import SentenceTransformer

# Daten laden
df = pd.read_csv('output/bverfg_rag_corpus.csv')

# Embeddings erstellen
model = SentenceTransformer('sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2')
embeddings = model.encode(df['content'].tolist())
```

### R-Beispiel
```r
# Daten laden
corpus <- readRDS("output/bverfg_rag_corpus.rds")

# Text-Chunks erstellen (für große Texte)
library(text)
chunks <- corpus[, .(
  chunk = stringr::str_sub(content, 
                          seq(1, nchar(content), 1000), 
                          seq(1000, nchar(content), 1000))
), by = id]
```

## ⚙️ Konfiguration

Anpassungen in `config.toml`:
```toml
[cores]
max = true      # Alle CPU-Kerne nutzen
number = 8      # Oder feste Anzahl

[debug]
toggle = false  # Für Tests auf true setzen
pages = 20      # Testmodus: nur 20 Seiten

[rag]
max_text_length = 10000  # Max. Zeichen pro Text
chunk_overlap = 200      # Überlappung für Chunking
```

## 🔧 Systemanforderungen

- **Minimal**: 2 GB RAM, 1 GB Festplatte
- **Empfohlen**: 4 GB RAM, Multi-Core CPU
- **Internet**: Für Download der Entscheidungen

## 🔄 Inkrementelle Updates

**Intelligentes Download-System:**
- ✅ **Beim ersten Lauf**: Alle Entscheidungen werden heruntergeladen
- ✅ **Bei späteren Läufen**: Nur neue Entscheidungen 
- ✅ **Cache-System**: HTML-Dateien werden in `html_cache/` gespeichert
- ✅ **Deutlich schneller**: Keine unnötigen Re-Downloads

**Cache verwalten:**
```r
# Cache-Status prüfen
list.files("html_cache", pattern = "\\.html$") |> length()

# Cache löschen (für kompletten Neustart)
unlink("html_cache", recursive = TRUE)
```

## 📝 Lizenz

- **Daten**: Creative Commons Zero (CC0)
- **Code**: GNU GPL v3

## 🤝 Beitragen

Issues und Pull Requests sind willkommen!

## 📧 Kontakt

Basiert auf dem ursprünglichen Werk von Seán Fobbe.
Angepasst für RAG-Anwendungen.



