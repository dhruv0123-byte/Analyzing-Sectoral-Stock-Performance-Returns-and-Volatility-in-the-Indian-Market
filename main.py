import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

data = pd.read_csv('path/to/sector_performance.csv')

plt.figure(figsize=(10, 6))
sns.barplot(x='sector', y='average_return', data=data)
plt.title('Average Returns by Sector')
plt.xlabel('Sector')
plt.ylabel('Average Return (%)')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('images/average_returns_by_sector.png')
plt.show()

plt.figure(figsize=(10, 6))
sns.scatterplot(x='volatility', y='average_return', hue='sector', data=data, s=100)
plt.title('Return vs Volatility by Sector')
plt.xlabel('Volatility (%)')
plt.ylabel('Average Return (%)')
plt.tight_layout()
plt.savefig('images/return_vs_volatility.png')
plt.show()

plt.figure(figsize=(10, 6))
sns.boxplot(x='sector', y='average_return', data=data)
plt.title('Return Distribution by Sector')
plt.xlabel('Sector')
plt.ylabel('Return (%)')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('images/return_distribution.png')
plt.show()

