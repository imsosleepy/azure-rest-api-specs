import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.OpenAI;

@added(ServiceApiVersions.v2024_07_01_Preview)
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

alias OptionalNullableMetadata = {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("A set of up to 16 key/value pairs that can be attached to an object, used for storing additional information about that object in a structured format. Keys may be up to 64 characters in length and values may be up to 512 characters in length.")
  metadata?: Record<string> | null;
};

@added(ServiceApiVersions.v2024_07_01_Preview)
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

  ...OptionalNullableMetadata;
}

@added(ServiceApiVersions.v2024_07_01_Preview)
@doc("The request counts for the batch")
model RequestCounts {
  @doc("The total number of requests in the batch.")
  total: int32;
  @doc("The number of requests that were successfully completed.")
  completed: int32;
  @doc("The number of requests that failed.")
  failed: int32;
}

@added(ServiceApiVersions.v2024_07_01_Preview)
@doc("Represents the response value of a batch API. This object is included in all response values for the create, retrieve, cancel, and list batch APIs.")
model BatchesResponse {
  @doc("The ID of the requested batch.")
  id: string;
  @doc("The type of the response object, which is always 'batch'.")
  object: "batch";
  @doc("The API endpoint used for the batch.")
  endpoint: string;
  @doc("Any errors that occurred during the processing of the batch.")
  errors?: string;
  @doc("The ID of the input file.")
  inputFileId: string;
  @doc("The completion window for the batch.")
  completionWindow: string;
  @doc("The status of the batch.")
  status: string;
  @doc("The ID of the output file.")
  outputFileId: string;
  @doc("The ID of the error file.")
  errorFileId: string;
  @doc("The Unix timestamp (in seconds) for when the batch was created.")
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  createdAt: utcDateTime | null;
  @doc("The Unix timestamp (in seconds) for when the batch started processing.")
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  inProgressAt: utcDateTime | null;
  @doc("The Unix timestamp (in seconds) for when the batch expires.")
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  expiresAt: utcDateTime | null;
  @doc("The Unix timestamp (in seconds) for when the batch started finalizing.")
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  finalizingAt: utcDateTime | null;
  @doc("The Unix timestamp (in seconds) for when the batch was completed.")
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  completedAt: utcDateTime | null;
  @doc("The Unix timestamp (in seconds) for when the batch failed.")
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  failedAt?: utcDateTime | null;
  @doc("The Unix timestamp (in seconds) for when the batch expired.")
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  expiredAt?: utcDateTime | null;
  @doc("The Unix timestamp (in seconds) for when the batch started cancelling.")
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  cancellingAt?: utcDateTime | null;
  @doc("The Unix timestamp (in seconds) for when the batch was cancelled.")
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  cancelledAt?: utcDateTime | null;
  @doc("The request counts for the batch.")
  requestCounts: RequestCounts;

  ...OptionalNullableMetadata;
}

@added(ServiceApiVersions.v2024_07_01_Preview)
@doc("Represents the response value of a batch API. This object is included in all response values for the create, retrieve, cancel, and list batch APIs.")
model ListBatchesResponse {
  @doc("The type of the response object, which is always 'list'.")
  object: "list";
  @doc("A list of batch response objects.")
  data: BatchesResponse[];
  @doc("The ID of the first batch in the list.")
  firstId: string;
  @doc("The ID of the last batch in the list.")
  lastId: string;
  @doc("A boolean indicating whether there are more batches to retrieve.")
  hasMore: boolean;
}