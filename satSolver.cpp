#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
#include <time.h>
#include <set>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

clock_t t;

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
//uint indexOfNextLitToPropagate;
uint decisionLevel;

vector<vector<int> > clausesPos; // clauses[0][1] give the second clause where the lit 1 is positive
vector<vector<int> > clausesNeg;

vector<int> latencia;

bool shiet( pair<int,int> a ,pair<int,int>b) {return (a.second>b.second);}

void readClauses( ){
    // Skip comments
    char c = cin.get();
    while (c == 'c') {
        while (c != '\n') c = cin.get();
        c = cin.get();
    }
    // Read "cnf numVars numClauses"
    string aux;
    cin >> aux >> numVars >> numClauses;
    clauses.resize(numClauses);
    clausesPos.resize(numVars+1);
    clausesNeg.resize(numVars+1);
    latencia.resize(numVars);
    // Read clauses
    for (uint i = 0; i < numClauses; ++i) {
        int lit;
        while (cin >> lit and lit != 0) {
            clauses[i].push_back(lit);
            if (lit > 0) clausesPos[lit].push_back(i);
            else clausesNeg[-lit].push_back(i);
        }
    }
    vector<pair<int,int> >vpAux(numVars+1);
    for (int i = 1; i < numVars+1; ++i) {
        pair <int,int> pAux;
        pAux.first = i;
        pAux.second = min(clausesPos[i].size(),clausesNeg[i].size());
        vpAux[i] = pAux;

    }
    sort(vpAux.begin()+1, vpAux.end(), shiet);
     for (int i = 1; i < numVars+1; ++i) latencia[i-1] = vpAux[i].first;


}



int currentValueInModel(int lit){
    //cout << "valueinmodel" << endl;
    if (lit >= 0) return model[lit];
    else {
        if (model[-lit] == UNDEF) return UNDEF;
        else return 1 - model[-lit];
    }
}


void setLiteralToTrue(int lit){
    //cout << "litotru" << endl;
    modelStack.push_back(lit);
    if (lit > 0) model[lit] = TRUE;
    else model[-lit] = FALSE;
}


bool propagateGivesConflict (vector<int> litsToPropagate) {
    //cout << "propagate" << endl;
    for (int l = 0; l < litsToPropagate.size(); ++l) {
        int cdSize;
        int lit = litsToPropagate[l];
        int ltp = abs(lit);
        //cout << "vamos a propagar " << ltp << endl;
        if (model[abs(lit)] == TRUE) {
            cdSize = clausesNeg[ltp].size();
            //cout << "El siz es: " << cdSize << endl;
            for (uint i = 0; i < cdSize; ++i) {
                //cout << i << endl;
                bool someLitTrue = false;
                int numUndefs = 0;
                int lastLitUndef = 0;
                //cout << "Estamos mirando la clausula " << clausesNeg[ltp][i] << "y está compuesto por lo siguiente:"<< endl;
                for (uint k = 0; not someLitTrue and k < clauses[clausesNeg[ltp][i]].size(); ++k){
                    //cout << clauses[clausesNeg[ltp][i]][k] << " ";
                    int val = currentValueInModel(clauses[clausesNeg[ltp][i]][k]);
                    if (val == TRUE) someLitTrue = true;
                    else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[clausesNeg[ltp][i]][k]; }
                }
                //cout << endl;
                if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
                else if (not someLitTrue and numUndefs == 1) {
                    setLiteralToTrue(lastLitUndef);
                    litsToPropagate.push_back(lastLitUndef);
                }
            }
        }
        else {
            cdSize = clausesPos[ltp].size();
            for (uint i = 0; i < cdSize; ++i) {
                //cout << i << endl;
                bool someLitTrue = false;
                int numUndefs = 0;
                int lastLitUndef = 0;
                for (uint k = 0; not someLitTrue and k < clauses[clausesPos[ltp][i]].size(); ++k){
                    int val = currentValueInModel(clauses[clausesPos[ltp][i]][k]);
                    if (val == TRUE) someLitTrue = true;
                    else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[clausesPos[ltp][i]][k]; }
                }
                if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
                else if (not someLitTrue and numUndefs == 1) {
                    setLiteralToTrue(lastLitUndef);
                    litsToPropagate.push_back(lastLitUndef);
                }
            }
        }
    }
    return false;
}


void backtrack(){
    //cout << "backtrack" << endl;
    uint i = modelStack.size() -1;
    int lit = 0;
    while (modelStack[i] != 0){ // 0 is the DL mark
        lit = modelStack[i];
        model[abs(lit)] = UNDEF;
        modelStack.pop_back();
        --i;
    }
    // at this point, lit is the last decision
    modelStack.pop_back(); // remove the DL mark
    --decisionLevel;
    setLiteralToTrue(-lit);  // reverse last decision
}


// Heuristic for finding the next decision literal:
int getNextDecisionLiteral(){
    //cout << "NextDecisionLiteral" << endl;
    int lSize = latencia.size();
    for (uint i = 0; i < lSize; ++i) {// stupid heuristic:
        //cout << "el lit: " << i << " es " << model[i] << endl;
        if (model[latencia[i]] == UNDEF) return i;  // returns first UNDEF var, positively

    }
    return 0; // reurns 0 when all literals are defined
}

void checkmodel(){
    for (int i = 0; i < numClauses; ++i){
        bool someTrue = false;
        for (int j = 0; not someTrue and j < clauses[i].size(); ++j)
            someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
        if (not someTrue) {
            cout << (clock()-(float)t)/CLOCKS_PER_SEC << endl;
            cout << "Error in model, clause is not satisfied:";
            for (int j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << "->" << currentValueInModel(clauses[i][j]) << " ";
            cout << endl;

            exit(1);
        }
    }
}

int main(){ 
    t = clock();
    readClauses(); // reads numVars, numClauses and clauses
    model.resize(numVars+1,UNDEF);
    decisionLevel = 0;

    // DPLL algorithm
    while (true) {
        int decisionLit = getNextDecisionLiteral();
        //cout << decisionLit << endl;
        if (decisionLit == 0 and decisionLevel != 0) { checkmodel(); cout << (clock()-(float)t)/CLOCKS_PER_SEC  << " SATISFIABLE" << endl; return 20; }
        // start new decision level:
        modelStack.push_back(0);  // push mark indicating new DL
        ++decisionLevel;
        setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
        vector<int> aux(1);
        aux[0] = decisionLit;
        while ( propagateGivesConflict(aux) ) {
            if ( decisionLevel == 0) { cout << (clock()-(float)t)/CLOCKS_PER_SEC << " UNSATISFIABLE" << endl; return 10; }
            backtrack();
        }

    }
}  
