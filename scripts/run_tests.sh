#!/bin/bash

# Test runner script for BMC Doctor App project
# Usage:
#   ./scripts/run_tests.sh          - Run all tests
#   ./scripts/run_tests.sh cover    - Run tests with coverage
#   ./scripts/run_tests.sh report  - Generate HTML coverage report
#   ./scripts/run_tests.sh all      - Run tests, coverage, and report

set -e

FLUTTER="${FLUTTER:-flutter}"
COVERAGE_DIR="coverage"
HTML_DIR="$COVERAGE_DIR/html"
LCOV_FILE="$COVERAGE_DIR/lcov.info"

run_tests() {
    echo "=========================================="
    echo "Running Tests..."
    echo "=========================================="
    $FLUTTER test
    echo ""
    echo "=========================================="
    echo "All Tests Passed!"
    echo "=========================================="
}

run_coverage() {
    echo "=========================================="
    echo "Running Tests with Coverage..."
    echo "=========================================="
    $FLUTTER test --coverage
    echo ""
    # Exclude generated files (g.dart) from coverage report by removing
    # entire lcov record blocks for .g.dart files
    if [ -f "$LCOV_FILE" ]; then
        awk '
            /^SF:.*\.g\.dart$/ { skip = 1; next }
            /^SF:.*_model\.dart$/ { skip = 1; next }
            /^SF:.*model\.dart$/ { skip = 1; next }
            /^SF:.*lib\/core\// { skip = 1; next }
            /^SF:.*lib\/app\/models\// { skip = 1; next }
            /^SF:.*lib\/app\/widgets\// { skip = 1; next }
            /^SF:.*lib\/.*\/models\// { skip = 1; next }
            /^SF:.*lib\/.*\/model\// { skip = 1; next }
            /^SF:.*test\/helpers\// { skip = 1; next }
            /^SF:.*lib\/app\/localization\// { skip = 1; next }
            /^SF:.*lib\/test\/helpers\/test_localization_mixin\.dart$/ { skip = 1; next }
            /^SF:.*lib\/features\/speech_to_text\/data\/repositories\/speech_to_text_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/app\/data\/repositories\/analytics_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/app\/data\/repositories\/noop_analytics_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/app\/data\/repositories\/certificate_installer_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/app\/data\/repositories\/pin_verification_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/app\/data\/repositories\/private_dns_checker_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/app\/data\/repositories\/vanilla_flavor_gate_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/app\/data\/repositories\/security_check_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/app\/domain\/repositories\/security_check_repository\.dart$/ { skip = 1; next }
             /^SF:.*lib\/app\/domain\/repositories\/screen_protector_controller_repository\.dart$/ { skip = 1; next }
            /^SF:.*lib\/app\/data\/repositories\/screen_protector_controller_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/features\/local_auth\/data\/repositories\/local_auth_repository_impl\.dart$/ { skip = 1; next }
            /^SF:.*lib\/flavor\// { skip = 1; next }
            skip && /^SF:/ { skip = 0 }
            skip && /^end_of_record:/ { next }
            !skip { print }
        ' "$LCOV_FILE" > "$COVERAGE_DIR/lcov_filtered.info"
        mv "$COVERAGE_DIR/lcov_filtered.info" "$LCOV_FILE"
    fi
    echo ""
    echo "=========================================="
    echo "Tests with Coverage Passed!"
    echo "=========================================="
}

generate_report() {
    echo ""
    echo "=========================================="
    echo "Generating HTML Coverage Report..."
    echo "=========================================="
    if [ ! -f "$LCOV_FILE" ]; then
        echo "Error: $LCOV_FILE not found. Run 'cover' command first."
        exit 1
    fi
    if ! command -v genhtml >/dev/null 2>&1; then
        echo "Error: genhtml not found. Install lcov to generate the HTML report."
        echo "On Debian/Ubuntu: sudo apt install lcov"
        echo "On Fedora: sudo dnf install lcov"
        echo "On macOS: brew install lcov"
        exit 1
    fi
    genhtml "$LCOV_FILE" --output-directory="$HTML_DIR"
    echo ""
    echo "=========================================="
    echo "Coverage Report Generated:"
    echo "file://$(pwd)/$HTML_DIR/index.html"
    echo "=========================================="
}

open_report() {
    if [ -d "$HTML_DIR" ]; then
        echo "Opening coverage report..."
        open "$HTML_DIR/index.html" 2>/dev/null || xdg-open "$HTML_DIR/index.html" 2>/dev/null || echo "Open manually: $HTML_DIR/index.html"
    else
        echo "Coverage report not found. Run 'all' command first."
    fi
}

case "${1:-}" in
    "")
        run_tests
        ;;
    cover|c)
        run_coverage
        ;;
    report|r)
        generate_report
        ;;
    all|a)
        run_coverage
        generate_report
        echo ""
        open_report
        ;;
    open|o)
        open_report
        ;;
    help|h|"--help")
        echo "Usage: ./scripts/run_tests.sh [command]"
        echo ""
        echo "Commands:"
        echo "  (none)    Run all tests"
        echo "  cover, c  Run tests with coverage"
        echo "  report, r Generate HTML coverage report"
        echo "  all, a   Run tests with coverage and generate report"
        echo "  open, o  Open the HTML coverage report"
        echo "  help, h  Show this help message"
        ;;
    *)
        echo "Unknown command: $1"
        echo "Run './scripts/run_tests.sh help' for usage."
        exit 1
        ;;
esac
 