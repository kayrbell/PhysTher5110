# Load libraries
from plotnine import (
    ggplot, aes, geom_point, geom_smooth, geom_violin, geom_boxplot,
    facet_wrap, labs, scale_color_brewer, scale_fill_brewer,
    theme_minimal, theme_classic, theme_light, ggtitle
)
from plotnine.positions import position_dodge
from plotnine.themes import theme
from plotnine import save_as_pdf_pages
import pandas as pd
from sklearn import datasets
import matplotlib.pyplot as plt
import os

# Load iris dataset
iris = pd.DataFrame(datasets.load_iris(as_frame=True).frame)
iris.columns = ["Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"]

# 1. Basic scatterplot
p1 = (
    ggplot(iris, aes("Sepal.Length", "Sepal.Width", color="Species"))
    + geom_point(size=3, alpha=0.8)
    + scale_color_brewer(type="qual", palette="Dark2")
    + theme_minimal(base_size=14)
    + labs(
        title="Sepal Dimensions by Species",
        x="Sepal Length (cm)",
        y="Sepal Width (cm)"
    )
)

# 2. Scatterplot + trend lines
p2 = (
    ggplot(iris, aes("Sepal.Length", "Sepal.Width", color="Species"))
    + geom_point(size=2, alpha=0.5)
    + geom_smooth(method="lm", se=False)
    + scale_color_brewer(type="qual", palette="Set1")
    + theme_classic(base_size=14)
    + labs(title="Sepal Length vs Width with Trend Lines")
)

# 3. Faceted scatterplot
p3 = (
    ggplot(iris, aes("Petal.Length", "Petal.Width", color="Species"))
    + geom_point(alpha=0.7)
    + facet_wrap("~Species")
    + scale_color_brewer(type="qual", palette="Paired")
    + theme_light(base_size=14)
    + labs(title="Petal Dimensions by Species (Faceted)")
)

# 4. Violin + boxplot
p4 = (
    ggplot(iris, aes("Species", "Sepal.Length", fill="Species"))
    + geom_violin(alpha=0.5)
    + geom_boxplot(width=0.1, outlier_shape=None)
    + scale_fill_brewer(type="qual", palette="Set2")
    + theme_minimal(base_size=14)
    + labs(title="Distribution of Sepal Length by Species")
)

# 5. Combine multi-panel figure (plotnine doesn’t have patchwork directly)
# We can save each plot separately or use matplotlib's subplots for layout

fig, axs = plt.subplots(2, 2, figsize=(12, 8))
for ax, p in zip(axs.flat, [p1, p2, p3, p4]):
    p.draw(ax=ax)
plt.suptitle("Advanced Plotnine Examples with Iris Dataset", fontsize=16)
plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.show()

# 6. Export options
p1.save("iris_p1.pdf", width=6, height=4, dpi=72)
p1.save("iris_p1.png", width=6, height=4, dpi=300)

# 7. Loop through species to create individual plots
species_list = iris["Species"].unique()
for sp in species_list:
    sub_df = iris[iris["Species"] == sp]
    p = (
        ggplot(sub_df, aes("Sepal.Length", "Sepal.Width"))
        + geom_point(color="steelblue", size=3, alpha=0.7)
        + theme_minimal(base_size=14)
        + labs(
            title=f"Sepal Dimensions for {sp}",
            x="Sepal Length (cm)",
            y="Sepal Width (cm)"
        )
    )
    filename = f"iris_sepal_{sp}.pdf"
    p.save(filename, width=6, height=4)






# The same examples but using Seaborn/MatPlotLib ----
# a more traditional "Python" style
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
from sklearn import datasets

iris = pd.DataFrame(datasets.load_iris(as_frame=True).frame)
iris.columns = ["Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"]

sns.set_context("talk")

# 1. Basic scatterplot
plt.figure(figsize=(6, 4))
sns.scatterplot(data=iris, x="Sepal.Length", y="Sepal.Width", hue="Species", palette="Dark2", s=80, alpha=0.8)
plt.title("Sepal Dimensions by Species")
plt.xlabel("Sepal Length (cm)")
plt.ylabel("Sepal Width (cm)")
plt.tight_layout()
plt.show()

# 2. With linear trend lines
plt.figure(figsize=(6, 4))
sns.lmplot(data=iris, x="Sepal.Length", y="Sepal.Width", hue="Species", palette="Set1", ci=None, aspect=1.2)
plt.title("Sepal Length vs Width with Trend Lines")
plt.tight_layout()

# 3. Faceted scatterplot
g = sns.FacetGrid(iris, col="Species", hue="Species", palette="Paired", height=4)
g.map_dataframe(sns.scatterplot, x="Petal.Length", y="Petal.Width", alpha=0.7)
g.add_legend()
g.fig.suptitle("Petal Dimensions by Species (Faceted)", y=1.05)
plt.show()

# 4. Violin + boxplot
plt.figure(figsize=(6, 4))
sns.violinplot(data=iris, x="Species", y="Sepal.Length", inner=None, palette="Set2", alpha=0.5)
sns.boxplot(data=iris, x="Species", y="Sepal.Length", width=0.2, showcaps=True, boxprops={'facecolor':'none'}, showfliers=False)
plt.title("Distribution of Sepal Length by Species")
plt.tight_layout()
plt.show()

# 5. Combine all four plots
fig, axes = plt.subplots(2, 2, figsize=(12, 8))
sns.scatterplot(data=iris, x="Sepal.Length", y="Sepal.Width", hue="Species", palette="Dark2", ax=axes[0, 0])
sns.lmplot(data=iris, x="Sepal.Length", y="Sepal.Width", hue="Species", palette="Set1", ci=None, ax=axes[0, 1])  # requires adjustment for layout
sns.violinplot(data=iris, x="Species", y="Sepal.Length", palette="Set2", ax=axes[1, 0])
sns.boxplot(data=iris, x="Species", y="Sepal.Length", width=0.2, showfliers=False, ax=axes[1, 0])
sns.scatterplot(data=iris, x="Petal.Length", y="Petal.Width", hue="Species", palette="Paired", ax=axes[1, 1])
fig.suptitle("Advanced Seaborn Examples with Iris Dataset", fontsize=16)
plt.tight_layout(rect=[0, 0, 1, 0.96])
plt.show()

# 6. Automation / reproducibility: loop by species
for sp, sub_df in iris.groupby("Species"):
    plt.figure(figsize=(6, 4))
    sns.scatterplot(data=sub_df, x="Sepal.Length", y="Sepal.Width", color="steelblue", s=80, alpha=0.7)
    plt.title(f"Sepal Dimensions for {sp}")
    plt.xlabel("Sepal Length (cm)")
    plt.ylabel("Sepal Width (cm)")
    plt.tight_layout()
    plt.savefig(f"iris_sepal_{sp}.pdf", dpi=300)
    plt.close()
