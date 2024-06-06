import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Batch;

/**
 * Creates and executes a batch from an uploaded file of requests 
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/batches")
@added(ServiceApiVersions.v2024_07_01_Preview)
op createBatch(
  /** Creates and executes a batch from an uploaded file of requests */
  @body
  batchOptions: BatchOptions
): BatchesResponse;