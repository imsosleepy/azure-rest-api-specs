import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
namespace Azure.AI {

}

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
namespace Azure.AI.OpenAI {

}

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@client({
  name: "OpenAIClient",
  service: Azure.AI.OpenAI.Batch,
})
interface OpenAIClient {
  createBatch is Azure.AI.OpenAI.Batch.createBatch;
}