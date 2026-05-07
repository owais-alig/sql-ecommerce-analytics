# Olist E-Commerce SQL Analytics

End-to-end SQL analysis of 100K+ real Brazilian e-commerce orders 
using PostgreSQL. Covers revenue trends, seller performance, 
delivery analysis, product insights, and customer segmentation.

## Dataset
[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — 8 tables, 99K+ orders, 2016–2018.

## Analyses

| # | File | Business Question |
|---|------|-------------------|
| 1 | `01_revenue_trends.sql` | How did monthly revenue and MoM growth trend over time? |
| 2 | `02_seller_performance.sql` | Which sellers drive the most revenue — and do reviews back it up? |
| 3 | `03_delivery_performance.sql` | Which states experience the worst delivery delays? |
| 4 | `04_product_category.sql` | Which product categories lead in revenue and customer satisfaction? |
| 5 | `05_rfm_segmentation.sql` | How can customers be segmented by buying behaviour? |

## SQL Concepts Used
- Multi-table JOINs
- Aggregations with GROUP BY and HAVING
- Window functions: RANK(), NTILE(), LAG()
- CTEs (Common Table Expressions)
- Date/time functions: DATE_TRUNC(), EXTRACT()
- CASE WHEN for business logic
- Subqueries

## Key Findings
- Health & Beauty is the top revenue category (R$1.2M) with strong satisfaction (4.19/5)
- Orders arrive on average 8–10 days earlier than estimated across all states
- Top sellers by revenue do not always have the best review scores
- RFM segmentation reveals distinct Champions, Loyal, At Risk, and Lost customer groups
