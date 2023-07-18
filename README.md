# 𝛿z
The first implementation of zero-knowledge differential privacy.

Delta Z is the first Zero Knowledge [Differential Privacy](https://en.wikipedia.org/wiki/Differential_privacy) (ZKDP) protocol.

In 2009, [Netflix identified an opportunity to share their customer database](https://en.wikipedia.org/wiki/Differential_privacy) with the ML community to improve their recommender engine. All data was pseudoanonymous yet hackers were [able to reconstruct private information](https://www.wired.com/2010/03/netflix-cancels-contest/) about individuals using statistical methods.

Clearly, pseudoanonymity is flawed.

Differential privacy [provides mathematical guarantees](https://www.cis.upenn.edu/~aaroth/Papers/privacybook.pdf) that no personal information can ever be reconstructed from query results. However, it relies on a trusted data curator which is a single point-of-failure for [corruption](https://fortune.com/2023/07/12/harvard-business-school-francesca-gino-retractions-fabricated-data-dishonesty/) in a way that users are none-the-wiser.

Delta Z is a completely trustless DP solution. We have have [implemented key algorithms](https://github.com/manuj-mishra/zkdiffpriv) from differential privacy literature as a Cairo-based smart contracts deployed on StarkNet (goerli). This allows users to submit queries as normal but receive results with verifiably correct noise that doesn't hinder their analysis.

Architecture Diagram:

[Architecture Diagram](./architecture.png)

Differential Privacy summarised in one image:

[Differential Privacy summarised in one image](./differential-privacy-summary.png)
