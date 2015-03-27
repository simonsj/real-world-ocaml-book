(** Table of contents. Representation of the hierarchical structure of
    the book.
*)
open Core.Std
open Async.Std

type part_info = {
  number : int;
  title : string;
}

type section = {
  id : string;
  title : string;
}

(** Interpret as n-ary tree with depth 3. *)
type sections = (section * (section * section list) list) list

type chapter = {
  number : int;
  filename : string; (** basename *)
  title : string;
  part_info : part_info option;
  sections : sections;
}

type part = {
  info : part_info option;
  chapters : chapter list
}

(** Return all chapter numbers and names, ordered by chapter
    number. *)
val get_chapters : ?repo_root:string -> unit -> chapter list Deferred.t

val get_next_chapter : chapter list -> chapter -> chapter option

val group_chapters_by_part : chapter list -> part list

(** [get_sections filename html] returns the section structure within
    the chapter of the given file, to depth 3. The [filename] is only
    for error messages. *)
val get_sections : string -> Rwo_html.t -> sections

(** Useful for debugging. *)
val flatten_sections : sections -> section list
