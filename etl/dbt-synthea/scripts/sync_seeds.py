"""Copy source CSV inputs into the dbt seed directory.

This mirrors the SQLMesh demo behavior without relying on filesystem symlinks, so it
works consistently on Windows and Unix-like systems. Re-run whenever the upstream
CSV data changes.
"""

from __future__ import annotations

import shutil
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[3]
DBT_DIR = PROJECT_ROOT / "etl" / "dbt-synthea"
SEED_DIR = DBT_DIR / "seeds"

SYNTHETIC_SOURCE = PROJECT_ROOT / "data" / "syntheaRaw"
VOCAB_SOURCE = PROJECT_ROOT / "data" / "vocabulary"
REFERENCE_SOURCE = PROJECT_ROOT / "etl" / "sqlmesh-synthea" / "seeds"

SYNTHETIC_FILES = {
    "synthea_allergies.csv": "allergies.csv",
    "synthea_conditions.csv": "conditions.csv",
    "synthea_devices.csv": "devices.csv",
    "synthea_encounters.csv": "encounters.csv",
    "synthea_immunizations.csv": "immunizations.csv",
    "synthea_medications.csv": "medications.csv",
    "synthea_observations.csv": "observations.csv",
    "synthea_organizations.csv": "organizations.csv",
    "synthea_patients.csv": "patients.csv",
    "synthea_payer_transitions.csv": "payer_transitions.csv",
    "synthea_payers.csv": "payers.csv",
    "synthea_procedures.csv": "procedures.csv",
    "synthea_providers.csv": "providers.csv",
}

VOCAB_FILES = {
    "concept.csv": "concept.csv",
    "concept_relationship.csv": "concept_relationship.csv",
    "concept_class.csv": "concept_class.csv",
    "concept_ancestor.csv": "concept_ancestor.csv",
    "concept_synonym.csv": "concept_synonym.csv",
    "domain.csv": "domain.csv",
    "relationship.csv": "relationship.csv",
    "source_to_source_vocab_map.csv": "source_to_source_vocab_map.csv",
    "source_to_standard_vocab_map.csv": "source_to_standard_vocab_map.csv",
    "vocabulary.csv": "vocabulary.csv",
}

REFERENCE_FILES = {
    "reference_states_map.csv": "states_map.csv",
}


def _copy_group(dest_dir: Path, mapping: dict[str, str], source_root: Path) -> None:
    dest_dir.mkdir(parents=True, exist_ok=True)
    for dest_name, src_rel in mapping.items():
        src = source_root / src_rel
        if not src.exists():
            raise FileNotFoundError(f"Expected source file not found: {src}")
        dest_path = dest_dir / dest_name
        shutil.copy2(src, dest_path)


def main() -> None:
    _copy_group(SEED_DIR / "synthea", SYNTHETIC_FILES, SYNTHETIC_SOURCE)
    _copy_group(SEED_DIR / "vocab", VOCAB_FILES, VOCAB_SOURCE)
    _copy_group(SEED_DIR / "reference", REFERENCE_FILES, REFERENCE_SOURCE)
    print(f"Seeds synced into {SEED_DIR}")


if __name__ == "__main__":
    main()
