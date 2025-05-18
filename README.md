# DataAnalytics-Assessment

This repository contains solutions to a four-part SQL assessment designed to evaluate data analysis and problem-solving skills using MySQL.

---

## Question 1: High-Value Customers with Multiple Products

**Approach:**

* I identified customers with at least one **funded savings plan** (`is_regular_savings = 1`) and at least one **funded investment plan** (`is_a_fund = 1`).
* I ensured the deposits are successful (`transaction_status = 'success'`) and not failed transactions.
* I counted distinct plan IDs for each type and summed up the `confirmed_amount`, converting from **kobo to naira** using `/ 100`.
* The result was grouped by user and sorted by total deposits to highlight the highest contributors.

**Challenges:**

* Understanding the relationship between plans and savings accounts tables.

---

## Question 2: Transaction Frequency Analysis

**Approach:**

* I calculated the **average number of successful transactions per month per customer**.
* Used `DATE_FORMAT(transaction_date, '%Y-%m')` to get the count of **active months**.
* Categorized customers into three frequency segments: High (>=10), Medium (3–9), Low (<=2).
* Aggregated customer count and average transaction frequency by category.

**Challenges:**

* Ensuring query efficiency.

---

## Question 3: Account Inactivity Alert

**Approach:**

* Selected all plans (either `is_regular_savings` or `is_a_fund`) and **LEFT JOINed** with savings accounts to find the latest transaction per plan.
* Focused on **inflows only** by checking `confirmed_amount > 0`.
* Used `DATEDIFF` to compute days since the last transaction.
* Filtered to plans with **over 365 days of inactivity**.

**Challenges:**

* I was not sure if to include only successful transactions or not. I Initially considered `transaction_status`, but later determined it's irrelevant since **any inflow is considered activity**.

---

## Question 4: Customer Lifetime Value (CLV) Estimation

**Approach:**

* Calculated **tenure in months** using `TIMESTAMPDIFF(MONTH, date_joined, CURDATE())`.
* Counted successful transactions .
* Applied CLV formula: `(total_transactions / tenure) * 12 * avg_profit_per_transaction`, where `profit = 0.1%` of transaction value.
* Rounded the final CLV to two decimal places and ordered by highest CLV.

**Challenges:**

* **division by zero** in tenure.

---

## Summary

Each SQL file in this repository corresponds to a question in the assessment. 


