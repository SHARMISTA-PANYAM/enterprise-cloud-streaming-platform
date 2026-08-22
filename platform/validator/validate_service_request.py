import argparse
import json
import sys
from pathlib import Path

import yaml
from jsonschema import Draft202012Validator


PLATFORM_DIR = Path(__file__).resolve().parents[1]
DEFAULT_SCHEMA = PLATFORM_DIR / "schemas" / "service-request.schema.json"


def load_json(path: Path):
    with path.open("r", encoding="utf-8") as file:
        return json.load(file)


def load_yaml(path: Path):
    with path.open("r", encoding="utf-8") as file:
        return yaml.safe_load(file)


def format_error_path(error):
    if not error.absolute_path:
        return "<root>"

    return ".".join(str(part) for part in error.absolute_path)


def validate_service_request(request_path: Path, schema_path: Path) -> int:
    try:
        schema = load_json(schema_path)
        request = load_yaml(request_path)
    except FileNotFoundError as exc:
        print(f"ERROR: file not found: {exc.filename}")
        return 2
    except json.JSONDecodeError as exc:
        print(f"ERROR: invalid JSON schema: {exc}")
        return 2
    except yaml.YAMLError as exc:
        print(f"ERROR: invalid YAML: {exc}")
        return 2

    Draft202012Validator.check_schema(schema)

    validator = Draft202012Validator(schema)

    errors = sorted(
        validator.iter_errors(request),
        key=lambda error: list(error.absolute_path),
    )

    if errors:
        print(f"FAILED: {request_path}")

        for error in errors:
            path = format_error_path(error)
            print(f"  - {path}: {error.message}")

        return 1

    service_name = request["metadata"]["name"]
    environment = request["spec"]["environment"]

    print(
        f"PASSED: {service_name} service request "
        f"is valid for environment '{environment}'."
    )

    return 0


def main():
    parser = argparse.ArgumentParser(
        description="Validate a platform ServiceRequest YAML file."
    )

    parser.add_argument(
        "request",
        type=Path,
        help="Path to the ServiceRequest YAML file.",
    )

    parser.add_argument(
        "--schema",
        type=Path,
        default=DEFAULT_SCHEMA,
        help="Optional path to the JSON Schema.",
    )

    args = parser.parse_args()

    sys.exit(
        validate_service_request(
            request_path=args.request,
            schema_path=args.schema,
        )
    )


if __name__ == "__main__":
    main()