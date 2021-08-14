#!/bin/bash

if [[ $# -eq 0 ]]
then
    echo "Provide current git commit as an arugment"
    exit 1
fi

if [[ $(git rev-parse --abbrev-ref HEAD) == "master" ]]
then
    HISTORY=$(git log HEAD~1 --pretty=format:'%H' -n 1)
else
    ANCESTOR=$(git merge-base master $1)    
    HISTORY=$(git log "$ANCESTOR" --pretty=format:'%H' -n 1)
fi

PAYLOAD=$(
    echo "$HISTORY" | jq -Rsc \
        --arg c $1 \
        'split("\n") | map(select(. != "")) as $h | { current: $c, history: $h, threshold: 20 }'
)

RESPONSE=$(
    curl -f \
        -X POST \
        -H "Content-Type: application/json" \
        -d "$PAYLOAD" \
        "https://benchmark-ci.herokuapp.com/api/benchmarks"
)

echo $RESPONSE

if [[ $(echo "$RESPONSE" | jq -c '.success') == "false" ]]
then
    echo "A benchmark exceeded the threshold"
    exit 1
fi