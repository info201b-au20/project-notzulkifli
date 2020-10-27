# Final Project
Use this `REAMDE.md` file to describe your final project (as detailed on Canvas).

* **Why are you interested in this field/domain?**
  * We are interested in health disparities because they make us more aware of inequalities present in the medical world. This is relevant with the emergence of the COVID-19 pandemic and understanding how one person/group’s health and living conditions affect others around them, especially when a group is given more of a “burden” in terms of illness due to differences in resources .  

* **What other examples of data driven project have you found related to this domain (share at least 3)?**
  * [Key Facts on Health and Health care by race and Ethnicity](https://www.kff.org/racial-equity-and-health-policy/report/key-facts-on-health-and-health-care-by-race-and-ethnicity/)
  * [Poverty and Covid-19](https://www.frontiersin.org/articles/10.3389/fsoc.2020.00047/full)
  * [Washington Tracking Network](https://fortress.wa.gov/doh/wtn/WTNIBL/)
  * [Health disparities in Snohomish County](https://www.snohd.org/DocumentCenter/View/640/Health-Disparities-in-Snohomish-County-2016-PDF)

* **What data-driven question do you hope to answer about this domain (share at least 3)?**
  * Are areas with people of low economic standing more prone to certain illnesses such as COVID-19, asthma, and diabetes?
  * Do low income areas have access to health resources (hospitals, clinics, Planned Parenthood) close by (less than 15 miles away)?
  * Are there health disparities present between different ethnicities/races that lead them to have poor healthcare as compared to others?


* **Where did you download the data (e.g., a web URL)?**
  * _Health Data Answer_: We downloaded our data from the CDC Population Health Division. [US Chronic Disease Indicators](https://healthdata.gov/dataset/us-chronic-disease-indicators-cdi)
  * _DOH Answer_: This data was downloaded from the Washington State Department of Health. [COVID-19 in Washington State](https://www.doh.wa.gov/Emergencies/COVID19/DataDashboard)  
  * _Census Answer_: This data was downloaded from the Department of Homeland Security. [Homeland Infrastructure Foundation-Level Data](https://hifld-geoplatform.opendata.arcgis.com/datasets/hospitals?geometry=-136.291%2C44.532%2C-105.771%2C49.757)

* **How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**
  *  _Health Data Answer_: The data was collected by the Center for Disease Control and Prevention from US territory and state reports as well as Death Certificates. The data represents the different chronic diseases that are prevalent in varying US states and territories. In addition, it displays the gender, race, age, and crude rate of the reports.
  * _DOH Answer_: The data was collected by the DOH from Washington state county and hospital reports. The data displays the confirmed cases, confirmed deaths, and number of hospitalizations due to COVID_19. It is broken down by county, sex, age, and race/ethnicity.
  * _HIFLD_: The data was collected by the Homeland Infrastructure Foundation Level Data Subcommittee and the Arcgis database from individual state departments and federal sources. The data displays the hospital facilities located in the US states and territories. Some features represented include the hospital address, number of beds, number of staff, and population.

* **How many observations (rows) are in your data?**
  * _HealthData_: Year Reported (2 years)
    * 2019
    * 2020
  * _DOH_: County (WA: 39 Counties)
    * King
    * Pierce
    * Spokane
    * Yakima
    * Benton
    * Kitsap
    * Etc.
  * _Census_: State (1)
    * Washington

* **How many features (columns) are in the data?**
  * _HealthData_: 5
    * Location
    * Chronic Disease
    * Race/Ethnicity
    * Gender
    * Age
  * _DOH_: 5
    * Age
    * Date
    * Hospitalization
    * Deaths
  * _Homeland_: 4
    * Address
    * County
    * Number of beds
    * Number of staff


* **What questions (from above) can be answered using the data in this dataset?**
  * _HealthData_: This data can answer our question regarding health disparities in different ethnicities and races as it displays the chronic disease reporting's based on these indications as well as gender. In addition, we can pull data from the lower income areas that were reported to see if they are more prone to diseases listed in the dataset.
  * _DOH_: In terms of our questions the COVID-19 data can help draw connections between low income areas in Washington State and their number of COVID-19 cases and deaths. In terms of race and ethnicity, this dataset can help display the variations in COVID-19 cases and a person's race based on Washington population.
  * _Homeland_: This data helps answer our second question pertaining to low income areas and their access to healthcare nearby. We are able to use the hospital listings to see which areas of Washington have the nearest and furthest access to healthcare facilities near them based on the areas income listings.
