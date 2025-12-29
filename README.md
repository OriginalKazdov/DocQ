# DocQ — Cloud-Native Document Q&A MVP

DocQ is a cloud-oriented Document Question & Answer MVP designed to demonstrate how AI-enabled
systems are built incrementally and responsibly on modern cloud platforms.

The project focuses on **system design, data flow, and AI integration strategy**, rather than
framework-specific features. The current implementation uses Ruby on Rails as the application
layer, but the architecture is intentionally **cloud-first and service-driven**.

---

## Purpose

This project exists to showcase:
- Cloud-oriented thinking
- AI-ready data pipelines
- Incremental adoption of managed AI services
- Engineering trade-offs around cost, complexity, and scalability

DocQ is a **portfolio-grade MVP**, not a demo or tutorial project.

---

## Current Capabilities

- Document ingestion (text-based files)
- Document lifecycle tracking:
  - `uploaded`
  - `processing`
  - `ready`
  - `failed`
- Storage abstraction compatible with future cloud services
- Clear separation between ingestion, processing, and AI stages

---

## What the MVP Does

- Upload text-based documents (`.txt`, `.md`)
- Persist documents and metadata
- Track processing state explicitly
- Prepare documents for downstream AI workflows

---

## What the MVP Intentionally Does NOT Do

- OCR or scanned document processing
- Model training or fine-tuning
- Vendor lock-in at early stages
- Premature infrastructure complexity

These concerns are deferred until the system behavior is validated.

---

## High-Level System Flow

User Upload
↓
Document Ingestion
↓
Processing Stage
↓
Chunked Text Storage
↓
Retrieval Layer (planned)
↓
LLM Inference (planned)

Each stage is modeled explicitly to mirror real-world production pipelines.

---

## Technology Choices (MVP)

- Application layer: Ruby on Rails
- Database: PostgreSQL
- Storage: Local disk (Active Storage, development only)

These choices optimize for fast iteration and observability.
Cloud-managed services are introduced only when justified by system needs.

---

## Cloud & AI Roadmap (Planned)

- Chunk-based retrieval
- Retrieval-Augmented Generation (RAG)
- AWS Bedrock (embeddings and LLM inference)
- Amazon S3 for document storage
- IAM-based access control and cost-aware usage

The architecture allows each component to be replaced with managed cloud services
without redesigning the system.

---

## Architectural Principles

- Cloud-first mindset
- Incremental AI adoption
- Cost and complexity awareness
- Explicit, inspectable pipelines

This project prioritizes **engineering judgment over AI hype**.

---

## Local Development

### Requirements
- Ruby
- Rails
- PostgreSQL

### Setup

```bash
bundle install
bin/setup
bin/rails db:migrate
bin/rails s
Open: http://localhost:3000

License
MIT
