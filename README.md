# 🏷️ **Commercial Sales Performance Dashboard**

## 📘 **Project Overview**

This end-to-end analytics project examines the **U.S. Superstore dataset** using **SQL**, **Python**, and **Power BI** to uncover key insights into sales performance, profitability, customer behavior, returns, and operational efficiency.

The project includes:

* 📊 SQL-based descriptive & diagnostic analytics
* 🧪 Predictive modeling using Python
* 📈 Interactive Power BI dashboard
* 📝 Business insights & recommendations

---

## ⚙️ **Tech Stack**

| Layer           | Tools                                              |
| --------------- | -------------------------------------------------- |
| Database        | PostgreSQL                                         |
| Analytics       | SQL                                                |
| EDA + ML        | Python (pandas, scikit-learn, seaborn, matplotlib) |
| Visualization   | Power BI                                           |
| Version Control | Git & GitHub                                       |

---

## 🧩 **Project Workflow**

### **1. SQL Data Cleaning & Preparation**

* Standardized categories, regions, shipping modes
* Validated timestamps and formatting
* Removed duplicates
* Joined orders, returns, and manager tables
* Computed metrics like return rates and average ship days

---

# 🧮 **2. Descriptive Analytics (SQL)**

### **Sales Overview**

| Metric                 | Value        |
| ---------------------- | ------------ |
| **Total Sales**        | 2,297,200.86 |
| **Total Profit**       | 286,397.02   |
| **Avg. Discount Rate** | 15.62%       |
| **Total Orders**       | 5,009        |

📈 **Monthly Trend Insight:**
Sales peak in **March**, **September**, and **November**, with November being the highest-performing month.

---

# 🔍 **3. Diagnostic Analytics**

### **Sales & Profit by Category**

| Category            | Sales      | Profit     |
| ------------------- | ---------- | ---------- |
| **Technology**      | 836,154.03 | 145,454.95 |
| **Furniture**       | 741,999.80 | 18,451.27  |
| **Office Supplies** | 719,041.03 | 122,490.80 |

➡️ *Technology is the profit leader, while Furniture yields the lowest margin.*

---

### **Regional & Manager Performance**

| Region      | Manager           | Sales      | Profit     |
| ----------- | ----------------- | ---------- | ---------- |
| **West**    | Anna Andreadi     | 725,457.82 | 108,418.45 |
| **East**    | Chuck Magee       | 678,781.24 | 91,522.78  |
| **South**   | Cassandra Brandow | 391,721.91 | 46,749.43  |
| **Central** | Kelly Williams    | 501,239.89 | 39,706.36  |

➡️ *The West region leads in both sales and profitability.*

---

### **Segment & Customer Insights**

| Segment         | Sales        | Profit     | Customers |
| --------------- | ------------ | ---------- | --------- |
| **Consumer**    | 1,161,401.34 | 134,119.21 | 409       |
| **Corporate**   | 706,146.37   | 91,979.13  | 236       |
| **Home Office** | 429,653.15   | 60,298.68  | 148       |

➡️ *Consumer segment contributes the highest revenue and customer volume.*

---

### **Shipping Performance**

| Ship Mode    | Avg Sales | Avg Profit | Avg Discount (%) | Orders |
| ------------ | --------- | ---------- | ---------------- | ------ |
| Standard     | 227.58    | 27.49      | 16.00            | 5,968  |
| Second Class | 236.09    | 29.54      | 13.89            | 1,945  |
| Same Day     | 236.40    | 29.27      | 15.24            | 543    |
| First Class  | 228.50    | 31.84      | 16.46            | 1,538  |

➡️ *First Class has the highest average profit, although at a higher discount cost.*

---

# 🔁 **4. Return & Loss Analysis**

### **Overall Return Rate**

| Returned Orders | Total Orders | Return Rate |
| --------------- | ------------ | ----------- |
| 800             | 5,009        | **15.97%**  |

### **Profitability Impact of Returns**

| Status           | Total Sales  | Total Profit |
| ---------------- | ------------ | ------------ |
| **Returned**     | 180,504.28   | 23,232.36    |
| **Not Returned** | 2,116,696.58 | 263,164.66   |

➡️ *Returns significantly erode profitability, contributing only 8% of total profit.*

---

# 🚚 **5. Advanced Insights**

### **Delivery Efficiency (Avg Ship Days)**

| Ship Mode    | Avg Ship Days |
| ------------ | ------------- |
| Standard     | 5.01          |
| Second Class | 3.24          |
| First Class  | 2.18          |
| Same Day     | 0.00          |

➡️ *Delivery speed improves with higher-cost shipping modes.*

---

# 🤖 **6. Predictive Modeling (Python)**

A Linear Regression model was trained to predict **profit** using:

* Sales
* Quantity
* Discount

### **Model Performance**

* **R²:** 0.3111
* **MAE:** 54.47
* **RMSE:** 178.97

### **Key Coefficients**

| Feature      | Coefficient | Interpretation                                 |
| ------------ | ----------- | ---------------------------------------------- |
| **Sales**    | +0.172      | Higher sales increase profit                   |
| **Discount** | **-236.37** | Discounting strongly decreases profit          |
| **Quantity** | -2.15       | Higher quantity does not always improve profit |

➡️ *Discount is the strongest negative profit driver.*

---

# 📈 **7. Power BI Dashboard**

Includes:

* KPI Cards: Sales, Profit, Avg Discount, Return Rate
* Sales & Profit Over Time (Line Chart)
* Category/Sub-category Performance (Bar + Treemap)
* Regional Sales by Manager (Map)
* Segment Insights (Donut + Bar Charts)
* Discount vs Profit (Scatter Plot)
* Shipping Efficiency (Boxplot / Bar)
* Return Behavior (KPI + Bar)

A preview is included in `/visuals/dashboard_preview.png`.

---

# 📂 **Repository Structure**

```
end-to-end-superstore-analytics/
│
├── data/
│── sql/
├── notebooks/
├── visuals/
├── dashboard/
└── README.md/
```

---

# 🧠 **8. Key Business Insights**

* November is the highest-earning month—ideal for seasonal promotional planning.
* Technology is the most profitable category; Furniture needs pricing/discount review.
* Western region outperforms — replicate strategies used there.
* Consumer segment drives growth — potential for loyalty programs.
* Discounts dramatically reduce profit — optimize discount strategy.
* First Class offers best speed–profit balance despite higher discounting.
* Returns heavily erode margins — requires quality control or return-policy revision.

