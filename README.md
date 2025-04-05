
# 📊 AtliQ Mart Promotion Analysis

### 🎯 Problem Statement
AtliQ Mart, a retail giant in southern India with over 50 stores, ran festive promotional campaigns during **Diwali 2023** and **Sankranti 2024** on its branded products. The **Sales Director, Bruce Haryali**, seeks actionable insights to assess the effectiveness of these promotions and guide future strategies.

---

### 🏢 Domain
- **Industry**: Fast-Moving Consumer Goods (FMCG)  
- **Function**: Sales / Promotions  
- **Role**: Data Analyst (You are Peter Pandey 👨‍💻)

---

### 📌 Objectives
1. Analyze promotional performance during the festive periods.
2. Extract actionable insights from the data and present them clearly.
3. Respond to ad-hoc executive queries using SQL-based reporting.
4. Deliver a dashboard and presentation for the Sales Director.

---

### 📂 Project Structure
- `metadata/`: Dataset description and schema
- `recommended_insights.pdf`: Strategic tips from manager Tony Sharma
- `ad_hoc_requests.pdf`: Business questions from executives
- `dashboard.png`: Final visual dashboard
- `presentation.pptx`: Executive-level insights & recommendations
- `sql_queries.sql`: All SQL scripts used in the analysis

---

### ✅ Tasks Completed

#### 🔍 Data Understanding
- Explored all datasets and verified schema from metadata.
- Mapped key fields like `base_price`, `promo_type`, `city`, `quantity_sold`, and `campaign_name`.

#### 📈 Dashboard Design
- Designed a self-explanatory and interactive dashboard summarizing:
  - Revenue before vs. after promotions
  - Store distribution across cities
  - ISU% by category during Diwali
  - Top 5 products by Incremental Revenue %
  - High-value BOGOF products

#### 🧠 Insights Extracted
| Insight Type | Key Finding |
|--------------|-------------|
| 🛍️ **Promotions** | Diwali campaign had the highest revenue lift: ₹82.57M → ₹160.29M |
| 📦 **Top Performing Categories** | Home Appliances & Combo1 had the highest ISU% |
| 💸 **Top IR% Products** | Atliq Home Essential Combo (IR% = 136%) |
| 🏷️ **High-Value BOGOF** | Bedsheets & Immersion Rods priced above ₹1000 in BOGOF |
| 🏬 **Store Concentration** | Bengaluru has the highest store count (10 stores) |

#### 📄 Ad-hoc Reports
1. **BOGOF + Base Price > ₹500**  
   → 2 products identified: *Bedsheet Set* and *Immersion Rod*

2. **Store Count by City**  
   → Top 3 cities: Bengaluru (10), Chennai (8), Hyderabad (7)

3. **Campaign Revenue Impact**  
   | Campaign | Before | After |
   |----------|--------|-------|
   | Diwali   | ₹82.57M | ₹160.29M |
   | Sankranti| ₹58.13M | ₹87.70M |

4. **ISU% Ranking (Diwali)**  
   1. Home Appliances – 244%  
   2. Combo1 – 202%  
   3. Home Care – 80%

5. **Top 5 Products by IR%**  
   - Home Essential Combo: 136%  
   - Waterproof Immersion Rod: 83%  
   - High Glo LED Bulb: 81%

---

### 🖥️ Tools & Tech Stack
- **SQL**: For ad-hoc business reports
- **Excel / Power BI / Tableau**: For dashboard creation
- **Presentation**: Executive summary and insights

---

### 📌 Deliverables
- ✅ Promotion Impact Dashboard
- ✅ Executive-Level Presentation
- ✅ SQL Reports for Ad-hoc Questions
- ✅ Recommendations based on data insights

---

### 💡 Recommendations
- Prioritize combo deals & home appliances during festive sales.
- Reassess discounting on high-value products like bedsheets.
- Expand store presence in high-performing cities.
- Track ISU% and IR% metrics in real-time for future campaigns.
