import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../models/batch/batches.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

@doc("CCreates and executes a batch from an uploaded file of requests")
@added(ServiceApiVersions.v2024_06_01_Preview)
@actionSeparator("/")
@action("batches")
op createBatch is Azure.Core.ResourceAction<
  Deployment,
  BatchOptions,
  BatchesResponse
>;