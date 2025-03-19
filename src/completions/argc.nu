def _argc_completer [args: list<string>] {
  let list = argc --argc-compgen nushell "" ...$args
    | split row "\n"
    | each { |line| $line | split column "\t" value description }
    | flatten 
   let is_empty = ($list | is-empty) or ((($list | length) == 1) and ($list | last | get value | is-empty))

  if not $is_empty {
    $list
  } 
}

let external_completer = {|spans| 
    _argc_completer $spans
}

$env.config.completions.external.enable = true
$env.config.completions.external.completer = $external_completer
