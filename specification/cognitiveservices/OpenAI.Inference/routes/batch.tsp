import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../models/batch/batches.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

/**
 * Creates and executes a batch job from an uploaded file of requests.
 * @param batchOptions The details for the batch job.
 * @returns Information about the batch job.
 */
@post
@route("/batches")
@added(ServiceApiVersions.v2024_07_01_Preview)
op createBatches(
  /** The details for the batch job */
  @body
  batchOptions: BatchOptions
): BatchesResponse;

/**
 * Retrieves information about a batch job in progress.
 * @param batchId The ID of the batch to retrieve information about.
 * @returns The requested information about the specified batch job.
 */
@get
@route("/batches/{batchId}")
@added(ServiceApiVersions.v2024_07_01_Preview)
op getBatches(
  @path batchId: string
): BatchesResponse;

/**
 * Cancels a batch job in progress.
 * @param batchId The ID of the batch to cancel.
 * @returns Updated information about the batch job.
 */
@post
@route("/batches/{batchId}/cancel")
@added(ServiceApiVersions.v2024_07_01_Preview)
op cancelBatches(
  @path batchId: string
): BatchesResponse;

/**
 * Returns a list of batch jobs.
 * @param after A cursor for use in pagination. The `after` parameter is an object ID that defines your place in the list.
 * @param limit A limit on the number of objects to be returned. The limit can range between 1 and 100, with a default of 20.
 * @returns A list of batch jobs.
 */
@get
@route("/batches")
@added(ServiceApiVersions.v2024_07_01_Preview)
op listBatches(
  @query after?: string,
  @query
  @minValue(1)
  @maxValue(100)
  limit?: int32 | 20
): BatchesResponse[];