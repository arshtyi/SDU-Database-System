import pandas as pd
import sqlparse
import re
import os


def process_answers(input_excel, output_md):
    # Read the Excel file, assuming no header. Make sure openpyxl is installed.
    df = pd.read_excel(input_excel, header=None)

    results = []

    for _, row in df.iterrows():
        try:
            # Extract numbers representing experiment i and question j
            exp_str = str(row[1])
            q_str = str(row[2])

            exp_match = re.search(r"\d+", exp_str)
            q_match = re.search(r"\d+", q_str)

            if not exp_match or not q_match:
                continue

            exp_i = int(exp_match.group())
            q_j = int(q_match.group())

            ans_text = str(row[3]) if pd.notna(row[3]) else ""

            match = re.search(r"阅读(.*?)平台", ans_text, re.DOTALL)
            extracted_ans = match.group(1).strip() if match else ""

            # Remove Private Use Area (PUA) characters (like , ) and replace '·' with '.'
            extracted_ans = re.sub(r"[\uE000-\uF8FF]", "", extracted_ans)
            extracted_ans = extracted_ans.replace("·", ".")

            # Convert full-width characters to half-width
            extracted_ans = "".join(
                chr(ord(c) - 0xFEE0) if 0xFF01 <= ord(c) <= 0xFF5E else c
                for c in extracted_ans
            )

            # Remove extra empty lines
            extracted_ans = "\n".join(
                line for line in extracted_ans.splitlines() if line.strip()
            )

            # Format the output SQL
            extracted_ans = sqlparse.format(
                extracted_ans, reindent=True, keyword_case="upper"
            )

            results.append((exp_i, q_j, extracted_ans))

        except Exception as e:
            continue

    # Sort results sequentially
    results.sort(key=lambda x: (x[0], x[1]))

    # Append to output md
    os.makedirs(os.path.dirname(output_md), exist_ok=True)
    with open(output_md, "a", encoding="utf-8") as f:
        # Add a newline separator if appending to an existing non-empty file
        if f.tell() > 0 or (
            os.path.exists(output_md) and os.path.getsize(output_md) > 0
        ):
            f.write("\n")

        current_exp = None
        for exp_i, q_j, ans in results:
            if exp_i != current_exp:
                f.write(f"## Lab {exp_i}\n\n")
                current_exp = exp_i

            f.write(f"### T {q_j}\n\n")
            f.write(f"```sql\n{ans}\n```\n\n")


def main():
    input_file = r"answer\answer.xlsx"
    output_file = r"answer\answer.md"
    process_answers(input_file, output_file)
    print(f"提取完成，答案已追加至 {output_file}")


if __name__ == "__main__":
    main()
