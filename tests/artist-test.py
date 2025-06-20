# First run: execute these commands in a terminal first:
  # python3 -m pip install langchain
  # python3 -m pip install langchain_community
# After, and all subsequent tets, run:
  # python3 artist-test.py
from langchain import OpenAI, ConversationChain

artist_prompt = "Your role is a futuristic architectural concept artist..."
artist = ConversationChain(llm=OpenAI(model="gpt-4o"), prompt=artist_prompt)

response = artist.run("Sketch ideas for an industrial-style mining facility for Project Ember.")
print(response)

# Output: Cannot proceed. Need OpenAI API key. May be able to modify to use Ollama...

# Error text:
# $ python3 artist-test.py
# /home/nate/.local/lib/python3.10/site-packages/langchain/__init__.py:30: UserWarning: Importing OpenAI from langchain root module is no longer supported. Please use langchain_community.llms.OpenAI instead.
#   warnings.warn(
# /home/nate/.local/lib/python3.10/site-packages/langchain/__init__.py:30: UserWarning: Importing ConversationChain from langchain root module is no longer supported. Please use langchain.chains.ConversationChain instead.
#   warnings.warn(
# /home/nate/.local/lib/python3.10/site-packages/langchain/__init__.py:30: UserWarning: Importing OpenAI from langchain root module is no longer supported. Please use langchain_community.llms.OpenAI instead.
#   warnings.warn(
# /mnt/e/Projects/Dream Team/tests/artist-test.py:9: LangChainDeprecationWarning: The class `OpenAI` was deprecated in LangChain 0.0.10 and will be removed in 1.0. An updated version of the class exists in the :class:`~langchain-openai package and should be used instead. To use it run `pip install -U :class:`~langchain-openai` and import as `from :class:`~langchain_openai import OpenAI``.
#   artist = ConversationChain(llm=OpenAI(model="gpt-4o"), prompt=artist_prompt)
# Traceback (most recent call last):
#   File "/mnt/e/Projects/Dream Team/tests/artist-test.py", line 9, in <module>
#     artist = ConversationChain(llm=OpenAI(model="gpt-4o"), prompt=artist_prompt)
#   File "/home/nate/.local/lib/python3.10/site-packages/langchain_core/_api/deprecation.py", line 224, in warn_if_direct_instance
#     return wrapped(self, *args, **kwargs)
#   File "/home/nate/.local/lib/python3.10/site-packages/langchain_core/load/serializable.py", line 130, in __init__
#     super().__init__(*args, **kwargs)
#   File "/home/nate/.local/lib/python3.10/site-packages/pydantic/main.py", line 253, in __init__
#     validated_self = self.__pydantic_validator__.validate_python(data, self_instance=self)
# pydantic_core._pydantic_core.ValidationError: 1 validation error for OpenAI
#   Value error, Did not find openai_api_key, please add an environment variable `OPENAI_API_KEY` which contains it, or pass `openai_api_key` as a named parameter. [type=value_error, input_value={'model_kwargs': {}, 'nam...ne, 'http_client': None}, input_type=dict]
#     For further information visit https://errors.pydantic.dev/2.11/v/value_error
