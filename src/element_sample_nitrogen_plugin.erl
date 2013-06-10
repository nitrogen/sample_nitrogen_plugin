-module (element_sample_nitrogen_plugin).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

-export([
	reflect/0,
	render_element/1
]).

reflect() -> record_info(fields, sample_nitrogen_plugin).

render_element(_Rec = #sample_nitrogen_plugin{}) ->
	[
		<<"Hello! This is a sample Nitrogen Plugin">>
	].
