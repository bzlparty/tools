"Host Platform"

load("@platforms//host:constraints.bzl", _HOST_CONSTRAINTS = "HOST_CONSTRAINTS")
load("//lib:platforms.bzl", "platform_from_constraints")

HOST_PLATFORM = platform_from_constraints(_HOST_CONSTRAINTS)
HOST_CONSTRAINTS = _HOST_CONSTRAINTS
