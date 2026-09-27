# Olist Delivery Performance & Customer Satisfaction

An exploratory SQL analysis investigating how delivery performance relates to customer satisfaction using the Brazilian E-Commerce Public Dataset by Olist.

The project analyzes delivery delays across different severity levels, product categories, delivery routes, and order characteristics, then examines how delay severity relates to customer review scores.

---

## Project Overview

Late deliveries are relatively uncommon, but their impact on the customer experience can be substantial.

This project analyzes **96,476 delivered orders** to understand:

- How frequently orders are delivered late
- How severe delivery delays can be
- Which product categories and delivery routes experience higher delay rates
- Whether order and shipment characteristics are associated with delivery delays
- How customer satisfaction changes as delivery delays become more severe
- Whether the relationship between delay and satisfaction is consistent across categories and routes

---

## Key Findings

### Delivery Performance

**6.77% of analyzed orders were delivered late.**

Among late orders, delays ranged from 1 day to 188 days, with an average delay of approximately **10.6 days**.

### Delivery Risk Varies Across Categories and Routes

Delay rates varied substantially across product categories and delivery routes.

For example:

| Route | Orders | Delay Rate |
|---|---:|---:|
| São Paulo → São Paulo | 30,829 | 4.63% |
| São Paulo → Rio de Janeiro | 8,189 | 14.07% |
| São Paulo → Minas Gerais | 7,470 | 5.27% |

This indicates that delivery performance is not evenly distributed across the network.

### Customer Satisfaction Drops Sharply With Delay

| Delay | Avg. Review Score | Dissatisfaction Rate |
|---|---:|---:|
| On time / Early | 4.29 | 9.28% |
| 1–2 days late | 3.51 | 25.51% |
| 3–7 days late | 2.23 | 63.85% |
| 8–14 days late | 1.68 | 79.97% |
| 15+ days late | 1.72 | 78.29% |

Dissatisfaction rises from **9.28% for on-time orders to 63.85% after 3–7 days of delay**, showing a sharp deterioration in customer experience as delays become more severe.

The same general pattern can also be observed across different product categories and delivery routes.

---

## Methodology

### Data

The analysis uses the **Brazilian E-Commerce Public Dataset by Olist**, containing approximately 100,000 anonymized orders from 2016–2018.

The analysis combines information from:

- Orders
- Order items
- Products
- Product categories
- Customers
- Sellers
- Reviews

### Delivery Performance

Delivery delay was calculated by comparing the actual customer delivery date with the estimated delivery date.

Orders were classified into five delivery-performance groups:

- **On time / Early**
- **1–2 days late**
- **3–7 days late**
- **8–14 days late**
- **15+ days late**

Delay rate was then compared across product categories, delivery routes, order value, freight value, item count, and product weight.

### Customer Satisfaction

Customer satisfaction was evaluated using the Olist review score.

Reviews with a score of **1–2** were classified as dissatisfied.

The analysis compares:

- Average review score
- Dissatisfaction rate

across different levels of delivery delay.

### Segment Analysis

The relationship between delivery delay and customer satisfaction was further examined across product categories and seller-to-customer delivery routes to determine whether the observed pattern was concentrated in specific segments or appeared more broadly across the dataset.

---

## SQL Analysis

The project contains 11 SQL analyses:

| File | Analysis |
|---|---|
| `01_delay_days.sql` | Calculates delivery delay in days |
| `02_delay_buckets.sql` | Groups orders by delay severity |
| `03_delay_rate_product_category.sql` | Delay rate by product category |
| `04_delay_rate_delivery_route.sql` | Delay rate by delivery route |
| `05_delay_rate_order_value.sql` | Delay rate by order value |
| `06_delay_rate_freight_value.sql` | Delay rate by freight value |
| `07_delay_rate_number_of_items.sql` | Delay rate by number of items |
| `08_delay_rate_product_weight.sql` | Delay rate by product weight |
| `09_customer_satisfaction.sql` | Customer satisfaction by delay severity |
| `10_delivery_performance_product_category.sql` | Satisfaction patterns across product categories |
| `11_delivery_performance_delivery_route.sql` | Satisfaction patterns across delivery routes |

The analysis progresses from measuring delivery performance, to identifying where delays occur, and finally to examining how delivery performance relates to customer satisfaction.

---

## Tools

- **PostgreSQL**
- **SQL**
- **Data Analysis**
- **Data Visualization**
- **Data Storytelling**

---

## Repository Structure

```text
olist-delivery-analysis/
│
├── README.md
│
├── sql/
│   ├── 01_delay_days.sql
│   ├── 02_delay_buckets.sql
│   ├── 03_delay_rate_product_category.sql
│   ├── 04_delay_rate_delivery_route.sql
│   ├── 05_delay_rate_order_value.sql
│   ├── 06_delay_rate_freight_value.sql
│   ├── 07_delay_rate_number_of_items.sql
│   ├── 08_delay_rate_product_weight.sql
│   ├── 09_customer_satisfaction.sql
│   ├── 10_delivery_performance_product_category.sql
│   └── 11_delivery_performance_delivery_route.sql
│
└── presentation/
    └── Olist_Delivery_Analysis.pdf
