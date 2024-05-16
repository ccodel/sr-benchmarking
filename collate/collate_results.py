# A parser for lrat/lpr/lsr-check results files, and collates into a CSV.
# Usage: python collate_results.py <results_file>

import sys
import string
import os

def main():
    if len(sys.argv) != 2:
        print("Usage: python collate_results.py <results_file>")
        exit(-1)

    results_file = sys.argv[1]
    base_file = os.path.basename(results_file)
    base_file = os.path.splitext(base_file)[0]
    results = open(results_file, 'r')
    lines = results.readlines()

    # Check that "UNSAT" is contained in the file
    # if any("abc" in s for s in xs):
    if not any("s VERIFIED" in s for s in lines):
        print(f"\"VERIFIED not found in the file {results_file}\"")
        results.close()
        exit(-1)

    # Now parse out the runtime
    for line in lines:
        if "real" in line:
            time_str = line.split()[1]

            # Convert time string in format xmxx.xxxs to seconds
            time = 0.0
            time += float(time_str.split("m")[0]) * 60.0
            time += float(time_str.split("m")[1][:-1])
            print(f"{base_file}, {time}")
            results.close()
            return

    print("No runtime information found")


if __name__ == "__main__":
    main()