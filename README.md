# Period over period (PoP) analysis in Looker

<p>Many clients will want to compare a period in time (say, the current month) against another period in time (say, the previous month).
This is the basic principle of period over period analysis. Given that there are many different ways to split up a time frame,
there are many different types of period over period analysis. Here's a list of a few of them that have come up in client use cases:</p>

- CMTD vs LMTD (Current Month to Date vs Last Month To Date)
- MoM (Month over Month)
- YoY (Year over Year)
  - by Month
  - by Quarter
- QoQ (Quarter over Quarter)
  - by Month
- CMTD vs. Previous Year Full Month

## PoP analysis in Looker

Looker is equipped with tools that allow us to do Period over Period analysis in a variety of ways.
For a comprehensive list, check out [this great support article on Looker's site](https://help.looker.com/hc/en-us/articles/360050104194-Methods-for-Period-Over-Period-PoP-Analysis-in-Looker)

In this branch, we're going to investigate an option from [this article](https://blog.montrealanalytics.com/the-ultimate-guide-to-period-over-period-analysis-in-looker-f19358397f19) which allows for flexible analysis with a few filters
