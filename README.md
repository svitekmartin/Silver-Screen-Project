# Silver Screen Efficiency Analysis (Snowflake / dbt Project)

This dbt project implements an ELT pipeline designed to analyze operational and financial data for the Silver Screen cinema chain. The primary objective is to standardize and integrate data from multiple sources, transforming it into a consolidated analytical data mart. This enables a clear assessment of movie profitability across various cinema locations.

## Technology Stack
* **dbt Core**: For data transformation.
* **Snowflake**: As the data warehouse.
* **GitHub**: For version control.

## Data Sources
This project utilizes five raw CSV data files provided by Silver Screen. These source files are stored in snowflake directory of the repository and are ingested into the data warehouse by upload

| Source Name       | Description                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| `movie_catalogue` | Provides detailed records of films released in the year 2024.                |
| `invoices`        | Records of invoices issued for screening specific movies across different theater locations.    |
| `nj_001`          | Granular transactional data for all ticket sales at the NJ_001 location.        |
| `nj_002`          | Daily aggregated ticket sales data from the NJ_002 location.                     |
| `nj_003`          | Comprehensive transaction data covering all product types (e.g., tickets, snacks) from the NJ_003 location. |

## Project Structure
This project follows a layered model architecture—aligned with dbt best practices—for clarity and scalability:

* `models/staging: Performs initial cleaning and standardization of raw inputs. Each staging model corresponds directly to one of the five data sources.

* `models/intermediate: Combines and transforms data across sources. Core logic for aggregating sales data is implemented here.

* `models/marts: Contains final, analysis-ready data models. These are designed for consumption by BI tools, with mart_movie_final being the primary output.

* `tests/: Houses custom singular tests used to validate complex business rules beyond what generic tests can cover.

## How the setup was for the project


1.  **Load  Data:**
   Initially, i createtd a development enviroment in snowflake to load the raw files and later the created files by models in dbt


2.  **Build Models and Run Tests:**
    To build all models in order and execute all tests, i run the following command:
    ```bash
    dbt build
    ```
    Alternatively, i could run the commands separately:
    ```bash
    dbt run   # To build all models (tables/views)
    dbt test  # To run all data quality tests
    ```

3.  **Generate and View Documentation:**
    To build the documentation site and explore the model dependency graph (DAG):
    ```bash
    dbt docs generate
    dbt docs serve
    ```

## Data Models Overview
The data pipeline follows these steps:

1.  **Source Cleaning:** Raw data from TICKETSALES_NJ_001, TICKETSALES_NJ_002, TICKETSALES_NJ_003, INVOICES, and MOVIE_CATALOGUE is cleaed and standardized using the staging models.
2.  **Consolidated Sales Data:** Sales data, once cleansed, is consolidated and aggregated on a monthly basis within the int_sales_by_month model.
3.  **Mart Creation:** The final model, `mart_movie_final`, combines aggregated sales, costs, and movie details through `JOIN`s to produce a unified table ready for analysis.


### Core Features & Improvements
During development, the following data quality issues were addressed:

* **Invoice Data Reliability Issues:** The `invoice_id` was identified as non-unique, so the logic was updated to aggregate costs using a true business key—`month`, `location`, and `movie`—to ensure accurate cost calculations.

* **Custom Testing:** I created a custom SQL test to ensure that the combination of columns in the int_model is unique, thereby validating the accuracy of the aggregation logic.
