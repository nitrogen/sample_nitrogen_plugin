-module (element_sample_nitrogen_element).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

-export([
	reflect/0,
	render_element/1
]).

reflect() -> record_info(fields, sample_nitrogen_element).

render_element(_Rec = #sample_nitrogen_element{}) ->
	[
		<<"Hello! This is a sample Nitrogen Element">>
	].
