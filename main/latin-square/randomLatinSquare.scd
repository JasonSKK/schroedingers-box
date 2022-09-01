
~path = PathName(thisProcess.nowExecutingPath).pathOnly; // current path


// define function
~randomLatinSquare = { |order|
	("python3"+(~path+/+"./random_latin_square.py").standardizePath+order).unixCmdGetStdOutLines[0..order-1].collect{|item|
		("["++item.replace(" ", ",")++"]").interpret;
	};
};
//:
// get result
~randomLatinSquare.(10);

//:
// print as matrix
Matrix.newFrom(~randomLatinSquare.(10)).postmln;


//:
// We only need this to performed once for the whole experiment. This matrix will then always stay the same.

// Therefore save the result hard-coded in the patch.
// Copy the printed patrix from the Post window here:
~experimentOrder =
// -------- start -----------
[
	[ 9, 6, 3, 8, 7, 1, 0, 5, 2, 4 ],
	[ 2, 8, 9, 5, 3, 4, 7, 1, 0, 6 ],
	[ 3, 4, 7, 6, 0, 5, 2, 8, 9, 1 ],
	[ 4, 9, 1, 2, 5, 7, 8, 0, 6, 3 ],
	[ 7, 1, 0, 4, 2, 8, 9, 6, 3, 5 ],
	[ 5, 7, 8, 3, 6, 2, 4, 9, 1, 0 ],
	[ 0, 5, 2, 1, 9, 6, 3, 4, 7, 8 ],
	[ 6, 2, 4, 0, 1, 3, 5, 7, 8, 9 ],
	[ 8, 0, 6, 7, 4, 9, 1, 3, 5, 2 ],
	[ 1, 3, 5, 9, 8, 0, 6, 2, 4, 7 ]
 ]
// -------- end -----------
;
//:
// check if it was saved.
~experimentOrder.postln;

// get order for participant 3:
~experimentOrder[3]