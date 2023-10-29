import duckdb

conn = duckdb.connect('main.db')

tableNames = conn.execute("SELECT table_name FROM information_schema.tables ORDER BY table_name;").fetchall()
for table in tableNames:
    row_count = conn.execute(f"SELECT COUNT(*) FROM {table[0]}").fetchone()[0]
    print(f"{table[0]}: {row_count} rows")

conn.close()

