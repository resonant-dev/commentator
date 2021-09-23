import { useEffect, useReducer } from 'preact/hooks';
import { apiFetch } from '../utils/api';
import useChannel from './useChannel';

type Action = {
    type: ActionTypes;
    payload?: any;
};
type ActionTypes = 'FETCH_START' | 'FETCH_SUCCESS' | 'FETCH_ERROR' | 'CH_NEW_MSG';
type State<T> = {
    loading: boolean;
    data: T[];
    errorMsg: string | null;
    lastFetch: number | null;
    lastError: number | null;
};

const initialState = {
    loading: false,
    data: [],
    lastFetch: null,
    lastError: null,
    errorMsg: null,
};

const reducer = <T>(state: State<T>, { type, payload }: Action) => {
    switch (type) {
        case 'FETCH_START':
            return {
                ...state,
                loading: true,
            };
        case 'CH_NEW_MSG':
        case 'FETCH_SUCCESS':
            return {
                ...state,
                loading: false,
                data: payload,
                errormsg: null,
                lastFetch: Date.now(),
                lastError: null,
            };
        case 'FETCH_ERROR':
            return {
                ...state,
                loading: false,
                errormsg: payload,
                lastError: Date.now(),
            };
        default:
            return state;
    }
};

type Opts = {
    endpoint: string;
    channelRoom: string;
};

const useResource = <T>({ endpoint, channelRoom }: Opts) => {
    const [state, dispatch] = useReducer<State<T>, Action>(reducer, initialState);
    const { join, leave, subscribe } = useChannel(channelRoom);

    subscribe('new_msg', (item) => {
        console.log({ item });
        dispatch({ type: 'CH_NEW_MSG', payload: state.data.concat(item) });
    });

    const fetchComments = () => {
        dispatch({ type: 'FETCH_START' });
        apiFetch({ endpoint })
            .then(({ data }) => {
                dispatch({
                    type: 'FETCH_SUCCESS',
                    payload: data,
                });
            })
            .catch((err) => {
                dispatch({
                    type: 'FETCH_ERROR',
                    payload: err.message,
                });
            });
    };

    useEffect(() => {
        fetchComments();
        join();
        return () => {
            leave();
        };
    }, []);

    return {
        ...state,
    };
};

export default useResource;
