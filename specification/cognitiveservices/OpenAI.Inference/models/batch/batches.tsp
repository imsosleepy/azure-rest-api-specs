import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.OpenAI;

@added(ServiceApiVersions.v2024_06_01_Preview)
@doc("The OpenAI APIs supported by the Batch API")
union EndPointType {
  string,

  @doc("""
  Chat completions API given a list of messages comprising a conversation, 
  the model will return a response.
  """)
  chatCompletions: "/v1/chat/completions",
  @doc("""
  Embedding API get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.
  This API batches are also restricted to a maximum of 50,000 embedding inputs across all requests in the batch.
  """)
  embeddings: "/v1/embeddings",
  @doc("""
  Completions API Given a prompt, the model will return one or more predicted completions along with the probabilities of alternative tokens at each position.
  This API is deprecated and it is recommended to use the chat completions API.
  """)
  completions: "/v1/completions"
}

@added(ServiceApiVersions.v2024_06_01_Preview)
@doc("Creates and executes a batch from an uploaded file of requests")
model BatchOptions {
  @doc("""
  The ID of an uploaded file that contains requests for the new batch. This file must be uploaded with the purpose batch.
  """)
  inputFileId: string;
  @doc("""
  The endpoint to be used for all requests in the batch. Currently /v1/chat/completions, /v1/embeddings, and /v1/completions are supported.
  """)
  endpoint: EndPointType;
  @doc("""
  The time frame within which the batch should be processed. Currently only 24h is supported.
  """)
  completionWindow: "24h";
}

@added(ServiceApiVersions.v2024_06_01_Preview)
@doc("Represents the response value of a batch API. This object is included in all response values for the create, retrieve, cancel, and list batch APIs.")
model BatchesResponse {
  @doc("The ID of the requested batch")
  id: string;
  @doc("The type of the response object")
  object: "batch";
  @doc("The API endpoint used for the batch")
  endpoint: string;
  @doc("Any errors that occurred during the processing of the batch")
  errors?: string;
  @doc("The ID of the input file")
  inputFileId: string;
  @doc("The completion window for the batch")
  completionWindow: string;
  @doc("The status of the batch")
  status: string;
  @doc("The ID of the output file")
  outputFileId: string;
  @doc("The ID of the error file")
  errorFileId: string;
  @doc("The timestamp when the batch was created")
  createdAt: int32;
  @doc("The timestamp when the batch started processing")
  inProgressAt: int32;
  @doc("The timestamp when the batch expires")
  expiresAt: int32;
  @doc("The timestamp when the batch was finalizing")
  finalizingAt: int32;
  @doc("The timestamp when the batch was completed")
  completedAt: int32;
  @doc("The timestamp when the batch failed")
  failedAt?: int32;
  @doc("The timestamp when the batch expired")
  expiredAt?: int32;
  @doc("The timestamp when the batch was being cancelled")
  cancellingAt?: int32;
  @doc("The timestamp when the batch was cancelled")
  cancelledAt?: int32;
  @doc("The request counts for the batch")
  requestCounts: {
    @doc("Total number of requests")
    total: int32;
    @doc("Number of completed requests")
    completed: int32;
    @doc("Number of failed requests")
    failed: int32;
  };
  @doc("Additional metadata for the batch")
  metadata: {
    @doc("The customer ID")
    customerId: string;
    @doc("Description of the batch")
    batchDescription: string;
  };
}
