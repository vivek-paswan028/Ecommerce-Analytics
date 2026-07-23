import random
import csv
import time
from tqdm import tqdm


def reservoir_sample(input_path, output_path, sample_size=5_000_000):
    """
    Reservoir Sampling (Algorithm R)
    For datasets WITHOUT headers.
    """

    reservoir = []

    print(f"Starting reservoir sampling: {sample_size:,} rows...")
    start = time.time()

    with open(input_path, "r", encoding="utf-8") as f:
        reader = csv.reader(f)

        for i, row in enumerate(tqdm(reader, desc="Sampling")):

            if i < sample_size:
                reservoir.append(row)
            else:
                j = random.randint(0, i)

                if j < sample_size:
                    reservoir[j] = row

    with open(output_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerows(reservoir)

    elapsed = time.time() - start

    print(f"✓ Sampled {len(reservoir):,} rows in {elapsed:.1f} seconds")
    print(f"✓ Saved to: {output_path}")


if __name__ == "__main__":

    reservoir_sample(
        input_path="data/raw/userbehavior/UserBehavior.csv",
        output_path="data/samples/sample_5M.csv",
        sample_size=5_000_000
    )