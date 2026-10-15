/* System functions only inFAMOUS First Light (CUSA00575 1.04) imports, on top of what Second Son
 * needs (runtime_infamous.c): the "A" (account id) variants of NpScore/NpTus (leaderboards, the
 * Paper Trail / photo-mode friend data) and two NpWebApi calls. All describe an offline console
 * whose user is signed out of PSN, like runtime_services.c:
 *  - title contexts and requests get fresh ids, so setup code succeeds;
 *  - an async score/TUS request is accepted (0) and finishes at the first poll with
 *    SCE_NP_ERROR_SIGNED_OUT, the order a real console reports a request it could not send;
 *  - web API contexts and requests fail at once. */
#include <stdint.h>
#include <stdio.h>
#include "runtime.h"

#define NP_SIGNED_OUT ((int32_t)0x80550006)
#define NP_INVALID_ARGUMENT ((int32_t)0x80550003)

static void once(const char *what) {
    static const char *seen[16];
    static int count;
    for (int i = 0; i < count; ++i) if (seen[i] == what) return;
    if (count < 16) seen[count++] = what;
    printf("Runtime: %s (First Light, offline)\n", what);
}
static int32_t new_id(void) {
    static int32_t next = 0x300;
    return __atomic_add_fetch(&next, 1, __ATOMIC_RELAXED);
}

/* sceNpScoreCreateNpTitleCtxA / sceNpTusCreateNpTitleCtxA(service label, self user id). */
static ABI int32_t title_ctx(uint32_t label, int32_t user) {
    (void)label; (void)user;
    once("NpScore/NpTus title context");
    return new_id();
}
/* sceNpTusCreateRequest(title context). */
static ABI int32_t tus_request(int32_t ctx) { (void)ctx; return new_id(); }
static ABI int32_t ok(void) { return 0; }
/* Every *Async call takes the request id first; the rest of the arguments are not read. */
static ABI int32_t async_accepted(int32_t request) {
    (void)request;
    once("NpScore/NpTus async request");
    return 0;
}
/* sceNpScorePollAsync / sceNpTusPollAsync(request, out result): 0 = finished. */
static ABI int32_t poll_async(int32_t request, int32_t *result) {
    (void)request;
    if (!result) return NP_INVALID_ARGUMENT;
    *result = NP_SIGNED_OUT;
    return 0;
}
static ABI int32_t signed_out(void) {
    once("NpWebApi");
    return NP_SIGNED_OUT;
}

static const RuntimeExport exports[] = {
    {"sceNpScoreCreateNpTitleCtxA", title_ctx},
    {"sceNpScoreGetRankingByAccountIdAsync", async_accepted},
    {"sceNpScoreGetRankingByRangeAAsync", async_accepted},
    {"sceNpScoreRecordScoreAsync", async_accepted},
    {"sceNpScorePollAsync", poll_async},
    {"sceNpTusCreateNpTitleCtxA", title_ctx}, {"sceNpTusDeleteNpTitleCtx", ok},
    {"sceNpTusCreateRequest", tus_request}, {"sceNpTusDeleteRequest", ok},
    {"sceNpTusGetMultiSlotVariableAAsync", async_accepted},
    {"sceNpTusGetMultiUserVariableAAsync", async_accepted},
    {"sceNpTusSetMultiSlotVariableAAsync", async_accepted},
    {"sceNpTusPollAsync", poll_async},
    {"sceNpWebApiCreateContextA", signed_out}, {"sceNpWebApiSendRequest2", signed_out},
};
uintptr_t runtime_firstlight_resolve(const char *name) { return RUNTIME_LOOKUP(exports, name); }
