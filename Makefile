PROJECT = rabbitmq_custom_auth

# TODO find a way to use other dependencies only for make run-broker
# TODO try this in elixir plugin project as well, to include elixir dependency
# DEPS = amqp_client mochiweb
DEPS = rabbitmq_management amqp_client mochiweb
TEST_DEPS = rabbit

DEP_PLUGINS = rabbit_common/mk/rabbitmq-plugin.mk

# FIXME: Use erlang.mk patched for RabbitMQ, while waiting for PRs to be
# reviewed and merged.

ERLANG_MK_REPO = https://github.com/rabbitmq/erlang.mk.git
ERLANG_MK_COMMIT = rabbitmq-tmp

include rabbitmq-components.mk
include erlang.mk
