# Olist Delivery Performance & Customer Satisfaction

An exploratory data analysis investigating how delivery performance relates to customer satisfaction in Brazilian e-commerce.

## Project Overview

Late delivery is often treated as an operational issue. But how much does it matter to the customer experience?

This project analyzes 96,476 delivered orders from the Brazilian E-Commerce Public Dataset by Olist to explore the relationship between delivery performance and customer satisfaction.

The analysis looks at delivery delays across different levels of severity, product categories, and delivery routes, then examines how these patterns relate to customer review scores.

## Key Questions

- How frequently do orders arrive late?
- How severe are delivery delays?
- Are delays concentrated in certain product categories or delivery routes?
- How does delivery performance relate to customer satisfaction?
- Does this relationship remain consistent across different categories and routes?

## Key Findings

### 1. Late deliveries are relatively uncommon, but vary across segments

**6.77%** of analyzed orders were delivered later than their estimated delivery date.

Delay rates varied across product categories and delivery routes, suggesting that delivery performance is not evenly distributed across the platform.

### 2. Customer dissatisfaction rises sharply as delays become more severe

Average review scores declined substantially as delivery delays increased.

| Delivery Performance | Avg. Review Score | Dissatisfaction Rate |
|---|---:|---:|
| On time / Early | 4.29 | 9.28% |
| 1–2 days late | 3.51 | 25.51% |
| 3–7 days late | 2.23 | 63.85% |
| 8–14 days late | 1.68 | 79.97% |
| 15+ days late | 1.72 | 78.29% |

The largest deterioration occurs within the first several days of delay.

### 3. Delivery performance varies by route

Some high-volume delivery corridors showed substantially higher delay rates than others.

For example:

- São Paulo → São Paulo: **4.63%**
- São Paulo → Minas Gerais: **5.27%**
- São Paulo → Rio de Janeiro: **14.07%**

This suggests that delivery route is an important dimension to consider when evaluating operational performance.

### 4. The relationship between delays and dissatisfaction appears across segments

The decline in customer satisfaction was observed across different product categories and delivery routes.

This consistency strengthens the observed association between delivery delay and customer dissatisfaction, although the analysis does not establish causation.

## Methodology

The analysis was conducted using **PostgreSQL / SQL**.

The Olist datasets were joined across:

- Orders
- Order Items
- Products
- Product Categories
- Customers
- Sellers
- Reviews

Delivery performance was measured by comparing:

**Actual Delivery Date vs. Estimated Delivery Date**

Orders were then grouped into delay severity buckets:

- On time / Early
- 1–2 days late
- 3–7 days late
- 8–14 days late
- 15+ days late

Customer satisfaction was evaluated using review scores, with reviews of **1–2 stars** classified as dissatisfied.

## Dataset

**Brazilian E-Commerce Public Dataset by Olist**

The dataset contains approximately 100,000 anonymized orders made through Olist between **2016 and 2018** across multiple marketplaces in Brazil.

The dataset provides information on order status, pricing, freight, customer and seller locations, product characteristics, and customer reviews.

Source:

[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Tools

- **PostgreSQL**
- **SQL**
- **Data Analysis**
- **Data Visualization**
- **Data Storytelling**

## Repository Structure

```text
olist-delivery-analysis/
│
├── README.md
│
├── sql/
│   ├── 01_delivery_performance.sql
│   ├── 02_delay_severity.sql
│   ├── 03_category_analysis.sql
│   ├── 04_route_analysis.sql
│   ├── 05_satisfaction_analysis.sql
│   └── 06_category_route_satisfaction.sql
│
└── presentation/
    └── Olist_Delivery_Analysis.pdf
