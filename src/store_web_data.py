import token_freq_fns as fns
import pandas as pd

tokens_112 = fns.token_count_congress(congress=112)
pac_ids = fns.get_pac_ids('2012')

results = pd.DataFrame(pd.DataFrame(index=pac_ids[:100], \
                                    columns=['congress','words']))

for pac_id in pac_ids[:10]:
    diffs = fns.compare_freq_pac(pac_id, congress_tokens = tokens_112)
    if diffs is not None:
        results.ix[pac_id,'congress'] = 112
        results.ix[pac_id,'words'] = diffs[:10].to_json()

results.to_csv('../data/webdata_pac.csv')
