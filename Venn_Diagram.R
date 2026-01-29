# Load library
library(VennDiagram)

# Load necessary libraries
library(readr)

# Load the data: "ASV_vennDiagram.csv"
# NOTICE!!! You will have to change the number of rows accordingly to the dataset you are currently plotting!!!!

# Read the CSV file (update with the correct file path)
dfv <- read_csv("/Users/neea/Documents/Project SPORES/R scripts and tables/ASV_vennDiagram.csv")

# Rename the dfv to the dataframe you want to work with (0.2, 20 or all the sizes in the same dataframe)
dfv <- ASV_venn

# View the first few rows to inspect the data
head(dfv)

# Convert the data to a format suitable for analysis
# Drop unnecessary columns: 'row number' and 'Sorted_genus'. Change the column numbers accordingly to the dataframe you are working with !!!!!!!!
df_cleaned <- dfv[, 2:299] #Leaving the rows and columns with the Location and the ASVs

# Replace NA with 0 to indicate absence of ASVs
df_cleaned[is.na(df_cleaned)] <- 0

# View the cleaned data to make sure the NAs are 0
head(df_cleaned)


# Create separate sets for each location
marine_ASVs <- df_cleaned %>% filter(Station_ID == "A17") 
marine_ASVs <- marine_ASVs[, 2:298] # Change the column numbers according to your dataframe


sbs_ASVs <- df_cleaned %>% filter(Station_ID == "BY15")
sbs_ASVs <- sbs_ASVs[, 2:298]


cbs_ASVs <- df_cleaned %>% filter(Station_ID == "BY5")
cbs_ASVs <- cbs_ASVs[, 2:298]


by31_ASVs <- df_cleaned %>% filter(Station_ID == "BY31")
by31_ASVs <- by31_ASVs[, 2:298]

# Convert each location's ASVs into logical vectors (TRUE for presence, FALSE for absence)

marine_ASVs <- colSums(marine_ASVs) > 0
sbs_ASVs <- colSums(sbs_ASVs) > 0
cbs_ASVs <- colSums(cbs_ASVs) > 0
by31_ASVs <- colSums(by31_ASVs) > 0


# Create a named list of ASV presence for each location
venn_data <- list(
  A17 = names(marine_ASVs)[marine_ASVs],
  BY5 = names(sbs_ASVs)[sbs_ASVs],
  BY15 = names(cbs_ASVs)[cbs_ASVs],
  BY31 = names(by31_ASVs)[by31_ASVs]
)

print(venn_data)

# Generate the Venn diagram but do not save to file
venn.plot <- venn.diagram(
  x = venn_data,
  category.names = c("A17", "BY5", "BY15", "BY31"),
  filename = "Venn_Diagram_Syndiniales_ASVs.png",  # Set to NULL to plot in RStudio instead of saving
  output = TRUE,
  fill = c("lightblue", "slateblue4","pink", "seagreen4"),
  alpha = 0.5,
  cex = 1.5,
  fontface = "bold",
  cat.cex = 1.2,
  cat.fontface = "bold"
)

# Plot the Venn diagram
grid::grid.draw(venn.plot)


#################################################################################
ASV_venn02 <- df2 %>%
  filter(Filter_size == "0.2") %>%
  filter(Taxa == "Syndiniales", Abundance > 0) %>%                                #This is to get the asv tables on the syndiniales inside each hots species in each location. Just remove the location variable to get the overall numbers
  group_by(Sorted_genus, Station_ID, OTU) %>%                       #Change order to Family to get clade level
  summarise(nasv = n_distinct(OTU)) %>% 
  pivot_wider(names_from = OTU, values_from = nasv)

ASV_venn20 <- df2 %>%
  filter(Filter_size == "20") %>%
  filter(Taxa == "Syndiniales", Abundance > 0) %>%                                #This is to get the asv tables on the syndiniales inside each hots species in each location. Just remove the location variable to get the overall numbers
  group_by(Sorted_genus, Station_ID, OTU) %>%                       #Change order to Family to get clade level
  summarise(nasv = n_distinct(OTU)) %>% 
  pivot_wider(names_from = OTU, values_from = nasv)

ASV_venn_marine <- df2 %>%
  filter(Station_ID == "A17") %>%
  filter(Sample_type == "Water") %>%
  filter(Taxa == "Syndiniales", Abundance > 0) %>%                                #This is to get the asv tables on the syndiniales inside each hots species in each location. Just remove the location variable to get the overall numbers
  group_by(Sorted_genus, sample._strata, OTU) %>%                       #Change order to Family to get clade level
  summarise(nasv = n_distinct(OTU)) %>% 
  pivot_wider(names_from = OTU, values_from = nasv)

ASV_venn_BY5 <- df2 %>%
  filter(Station_ID == "BY5") %>%
  filter(Sample_type == "Water") %>%
  filter(Taxa == "Syndiniales", Abundance > 0) %>%                                #This is to get the asv tables on the syndiniales inside each hots species in each location. Just remove the location variable to get the overall numbers
  group_by(Sorted_genus, sample._strata, OTU) %>%                       #Change order to Family to get clade level
  summarise(nasv = n_distinct(OTU)) %>% 
  pivot_wider(names_from = OTU, values_from = nasv)

ASV_venn_BY15 <- df2 %>%
  filter(Station_ID == "BY15") %>%
  filter(Sample_type == "Water") %>%
  filter(Taxa == "Syndiniales", Abundance > 0) %>%                                #This is to get the asv tables on the syndiniales inside each hots species in each location. Just remove the location variable to get the overall numbers
  group_by(Sorted_genus, sample._strata, OTU) %>%                       #Change order to Family to get clade level
  summarise(nasv = n_distinct(OTU)) %>% 
  pivot_wider(names_from = OTU, values_from = nasv)

ASV_venn_BY31 <- df2 %>%
  filter(Station_ID == "BY31") %>%
  filter(Sample_type == "Water") %>%
  filter(Taxa == "Syndiniales", Abundance > 0) %>%                                #This is to get the asv tables on the syndiniales inside each hots species in each location. Just remove the location variable to get the overall numbers
  group_by(Sorted_genus, sample._strata, OTU) %>%                       #Change order to Family to get clade level
  summarise(nasv = n_distinct(OTU)) %>% 
  pivot_wider(names_from = OTU, values_from = nasv)

#Plot the different depths 

# Rename the dfv to the dataframe you want to work with (0.2, 20 or all the sizes in the same dataframe)
dfv <- ASV_venn_marine
dfv <- ASV_venn_BY5
dfv <- ASV_venn_BY15
dfv <- ASV_venn_BY31

# View the first few rows to inspect the data
head(dfv)

# Convert the data to a format suitable for analysis
# Drop unnecessary columns: 'row number' and 'Sorted_genus'. Change the column numbers accordingly to the dataframe you are working with
df_cleaned <- dfv[, 2:242] #Leaving the rows and columns with the Location and the ASVs

# Replace NA with 0 to indicate absence of ASVs
df_cleaned[is.na(df_cleaned)] <- 0

# View the cleaned data to make sure the NAs are 0
head(df_cleaned)


# Create separate sets for each location
deep_ASVs <- df_cleaned %>% filter(sample._strata == "Deep") 
deep_ASVs <- deep_ASVs[, 2:241] # Change the column numbers according to your dataframe


medium_ASVs <- df_cleaned %>% filter(sample._strata == "Medium")
medium_ASVs <- medium_ASVs[, 2:241]


surface_ASVs <- df_cleaned %>% filter(sample._strata == "Surface")
surface_ASVs <- surface_ASVs[, 2:241]


# Convert each location's ASVs into logical vectors (TRUE for presence, FALSE for absence)

deep_ASVs <- colSums(deep_ASVs) > 0
medium_ASVs <- colSums(medium_ASVs) > 0
surface_ASVs <- colSums(surface_ASVs) > 0



# Create a named list of ASV presence for each location
venn_data <- list(
  Deep = names(deep_ASVs)[deep_ASVs],
  Medium = names(medium_ASVs)[medium_ASVs],
  Surface = names(surface_ASVs)[surface_ASVs]
)

print(venn_data)

# Generate the Venn diagram but do not save to file
venn.plot <- venn.diagram(
  x = venn_data,
  category.names = c("Deep", "Medium", "Surface"),
  filename = "ASVs_A17.jpeg",  # Set to NULL to plot in RStudio instead of saving
  output = TRUE,
  fill = c("lightblue", "slateblue4","pink"),
  alpha = 0.5,
  cex = 1.5,
  fontface = "bold",
  cat.cex = 1.2,
  cat.fontface = "bold",
  cat.dist = c(0.1, 0.1, 0.1) # distance from circles
)


# Plot the Venn diagram
grid::grid.draw(venn.plot)
